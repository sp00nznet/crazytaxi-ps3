# Progress log

Newest first. Runtime fixes land in [ps3recomp](https://github.com/sp00nznet/ps3recomp)
unless noted.

## 2026-09-26: day one, title screen and attract demo

Lift and build went through the first time with nothing title-specific:
8,655 functions, 197 imports across 16 libraries, two embedded SPU images
(43 KB and 159 KB), built against the ps3recomp runtime as it stood for
Tornado Outbreak that day.

First boot runs the whole front end with no fixes:

- "NOW LOADING", then the ESRB, Sega and CRIWARE logos, then the title
- CRI ADX starts its four threads, loads the sound-effect bank
  (`sounddata/adx/*.adx`, `sedata_adx.dat`) and opens the music tracks
- SPURS: one taskset, one task, SPU image 1, dispatched to the lifted code
  (`fp=0x53FCAE2F891FFB02`). Image 0 hasn't been used yet
- Trophy context registered ("Checking Trophy data." dialog opens and closes)
- The attract demo plays in-engine at about 25 fps

![title](media/title.png)

A 100 s run with `RSX_LIVE_DRAW=1`, cumulative at frame 2784:

```text
groups[seen=457971 exec=451293 empty=0 drop{fetch=0 degen=0 prim=6678 alloc=0 pso=0 ring=0 surface=0}]
textures[cached=559/1024 full=0 decodefail=0]
```

| Symptom | Where it stands |
|---|---|
| Large parts of the 3D city draw black (buildings, road) | Open. 1.5% of draw groups drop on `prim`: the primitive is one the live engine doesn't expand (not triangles, strips, fans or quads). Not yet shown to be the cause |
| `open FAILED: vfs\USRDIR\config.txt`, `song01.afs` | Neither file ships in the PSN build, and `song01.afs` is a Dreamcast-era name. The music the game plays opens from `sounddata/music_adx/` (`radiator.adx`, `orange_wednesday.adx`) |
| RSX methods `0x0194`, `0x018C`, `0x01B4`, `0x01B8`, `0x0198` (all `0xFEED0000`), `0x02B8`, `0x1D88`, `0x1D7C`, `0x0394`, `0x0398` unknown | 3–6 times each in a run, during setup. Not yet checked |
