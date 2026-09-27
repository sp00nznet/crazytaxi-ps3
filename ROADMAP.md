# Roadmap

## Next

- **Get the two ps3recomp fixes merged.** `fix/fp-flow-control` and #185, so
  this port builds against plain `master`.
- **Past the title.** START into the main menu, then Arcade into a fare.
- **Audio out.** Check that CRI ADX output reaches `cellAudio`.
- **`prim` drops.** 1.5% of draw groups use a primitive the live engine doesn't
  expand. Log which one and whether anything on screen is missing.

## Later

- Register the port in ps3recomp's `tools/regress_ports.toml` so a runtime
  change that breaks the title shows up in the shared regression run
  (the conformance harness for the family).
- Hero GIF of real gameplay once a fare can be driven.

## Out of scope

- Network features (`sceNp`, leaderboards). The game runs offline.
- Anything that needs the retail RAP in the repo. The EBOOT stays bring-your-own.
