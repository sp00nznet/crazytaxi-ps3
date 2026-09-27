# Extracting the game and decrypting the EBOOT

The PSN release is `UP0177-NPUB30242_00-CRAZYTAXIPACKAGE`. Everything here runs
on your own copy. Nothing it produces goes in the repo (see `.gitignore`).

## PKG → disc tree

`tools/pkg_extract.py` in ps3recomp opens both retail (finalized, AES-CTR) and
debug (SHA-1 keystream) packages:

```bash
python $PS3RECOMP/tools/pkg_extract.py pkg/Crazy-Taxi_Full.pkg extracted/Full
# rev=0x8000 keystream=finalized items=203  (pycryptodome)

mkdir -p vfs/PS3_GAME && cp -r extracted/Full/. vfs/PS3_GAME/
```

With `PS3_VFS_ROOT=vfs` the game reads from `vfs/PS3_GAME/USRDIR` and writes
its game data under `vfs/game/NPUB30242`.

## EBOOT: why the retail one needs a RAP

```text
$ python decrypt_self.py extracted/Full/USRDIR/EBOOT.BIN --keys keys
SELF v2 key_rev=0x0001 type=NPDRM auth_id=0x1010000001000003 fw=1.0000
decrypt_self.py: error: NPDRM license type 2 needs a RAP/klicensee this tool does not handle
```

License type 2 (local) wraps the content key in the account's RAP. You have
two options:

- **Your own RAP.** Install the RAP in RPCS3 and decrypt with
  `rpcs3 --decrypt EBOOT.BIN`, which writes the ELF.
- **A free-license EBOOT.** A type-3 build (`key_rev=0x0004`, same code and
  entry point) decrypts with the published `NP_klic_free`. This is what the
  current `game/EBOOT.elf` came from. It shipped in a debug-format PKG next to
  the retail one, together with a type-3 `CrazyTaxi.edat` license file.
  Overlay both over the retail tree:

  ```bash
  python $PS3RECOMP/tools/pkg_extract.py <free-license>.pkg extracted/Free
  cp extracted/Free/USRDIR/EBOOT.BIN extracted/Free/USRDIR/CrazyTaxi.edat vfs/PS3_GAME/USRDIR/
  python ../twistedmetal/tools/decrypt_self.py vfs/PS3_GAME/USRDIR/EBOOT.BIN \
      --keys ../GT5P/data/keys -o game/EBOOT.elf
  #   entry 0x364f00 -> OPD func=0x10230 toc=0x37e650
  #   game/EBOOT.elf  4.1 MB
  cp game/EBOOT.elf vfs/PS3_GAME/USRDIR/EBOOT.elf
  ```

`decrypt_self.py` lives in the twistedmetal port. Its `--keys` file is
scetool format and is never committed anywhere.

## The ELF

Section names are stripped. By address (the SPU images by file offset):

| Range | What |
|---|---|
| `0x10230..0x2A0CD4` | `.text` |
| `0x2A0CF8..0x2A2598` | `.lib.stub`, 197 import trampolines (the relift `--code-end`) |
| `0x318300`, `0x322D80` | embedded SPU ELFs, 43 KB and 159 KB |

`game/EBOOT.elf` is 4,082,552 bytes.
