#!/bin/sh
# Regenerate everything git-ignored: imports.json, the lifted PPU tree, the HLE
# NID table and the lifted SPU images. Run from the repo root.
set -e
PS3RECOMP="${PS3RECOMP:-/g/recomp/ps3}"

# .text is 0x10230..0x2A0CD4; the .lib.stub import trampolines follow at
# 0x2A0CF8..0x2A2598 (197 stubs). --code-end sits just past the stubs so
# --hle-stubs has something to rewrite, and no further: .rodata follows in the
# same R-X segment.
CODE_END=0x2A2598

python "$PS3RECOMP/tools/gen_imports.py" game/EBOOT.elf -o imports.json
python "$PS3RECOMP/tools/find_functions.py" game/EBOOT.elf --output analysis/functions.json

rm -rf src/recomp src/gen && mkdir -p src/recomp src/gen
python "$PS3RECOMP/tools/ppu_lifter.py" game/EBOOT.elf \
    --functions analysis/functions.json \
    --hle-stubs imports.json \
    --code-end "$CODE_END" \
    -o src/recomp

python "$PS3RECOMP/tools/gen_hle_nids.py" --all --out src/gen/ppu_hle_nids.cpp

# ---- SPU: the two embedded images --------------------------------------------
python "$PS3RECOMP/tools/extract_spu_images.py" game/EBOOT.elf --out analysis/spu
rm -rf src/spu_gen && mkdir -p src/spu_gen
python "$PS3RECOMP/tools/build_spu_workloads.py" \
    --images analysis/spu --lifted src/spu_gen \
    --out src/spu_gen/spu_workloads.c \
    --register-fn crazytaxi_spu_register_all --constructor --title crazytaxi
