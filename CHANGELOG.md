# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project
uses [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Build scaffold on the shared ps3recomp runtime: `CMakeLists.txt`, `build.py`,
  `tools/relift.sh`.
- Boots to the title screen and plays the attract demo.
- Docs: extracting the PKG and decrypting the EBOOT, and a progress log.

### Fixed

- The 3D city no longer draws black (ps3recomp `fix/fp-flow-control`: fragment
  program if/else and loops are decompiled instead of skipped).
- No more single black frames between presents (ps3recomp #185: flips are
  queued in the command FIFO).
