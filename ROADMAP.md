# Roadmap

## Next

- **Black 3D geometry in the attract demo.** Log the primitive type of the
  `prim` drops and check whether they account for the missing city. If they
  don't, dump one black draw's shaders and inputs.
- **Past the title.** START into the main menu, then Arcade into a fare.
- **Audio out.** Check that CRI ADX output reaches `cellAudio`.

## Later

- Register the port in ps3recomp's `tools/regress_ports.toml` so a runtime
  change that breaks the title shows up in the shared regression run
  (the conformance harness for the family).
- Hero GIF of real gameplay once a fare can be driven.

## Out of scope

- Network features (`sceNp`, leaderboards). The game runs offline.
- Anything that needs the retail RAP in the repo. The EBOOT stays bring-your-own.
