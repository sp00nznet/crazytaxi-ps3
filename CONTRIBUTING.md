# Contributing

Issues and pull requests are welcome.

- **Where a fix goes.** Anything that isn't specific to Crazy Taxi (HLE
  modules, the RSX renderer, the lifters) belongs in
  [ps3recomp](https://github.com/sp00nznet/ps3recomp), which follows the shared
  house style. This repo holds only the build configuration, docs and anything
  genuinely title-specific.
- **No game material.** Don't commit or attach dumps, EBOOTs, PKGs, keys, RAPs,
  lifted or decompiled source, or extracted assets, and that includes test
  fixtures and logs that embed them. Screenshots of the running port are fine.
- **Show it running.** A rendering or boot fix comes with a before/after frame
  (`LD_FRAME_DUMP`) or the log lines that changed, and an entry in
  `docs/progress.md` saying what the cause was.
- **Commits.** Imperative subject line, and a body that explains *why* when
  the change isn't obvious. Add an `Unreleased` entry to `CHANGELOG.md`.
