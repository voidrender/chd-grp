# chd-grp

A simple script to help me organize multidisc ROMs with CHD and M3U files into one directory per game. Specifically, this matches the expected format described in the [RetroDECK documentation for multidisc/file games](https://retrodeck.readthedocs.io/en/latest/wiki_management/multi-disk/multi-disk/?h=multi).

Given a directory of `x.m3u` (exactly one per _x_) and one or more `x (Disc y).chd` files, this script will group the m3u and chd files into a single directory per game.

## Expected File Structure

```
roms/
├── Game 1 (Disc 1).chd
├── Game 1 (Disc 2).chd
├── Game 1.m3u
├── Game 2 (Disc 1).chd
├── Game 2.m3u
├── Game 3 (Disc 1).chd
├── Game 3 (Disc 2).chd
└── Game 3.m3u
```

## Resulting File Structure

```
roms/
├── Game 1.m3u/
│   ├── Game 1.m3u
│   ├── Game 1 (Disc 1).chd
│   └── Game 1 (Disc 2).chd
├── Game 2.m3u/
│   ├── Game 2.m3u
│   └── Game 2 (Disc 1).chd
└── Game 3.m3u/
    ├── Game 3.m3u
    ├── Game 3 (Disc 1).chd
    └── Game 3 (Disc 2).chd
```

## Note

A tool like this will probably be added to RetroDECK eventually. See [RetroDECK/RetroDECK#286](https://github.com/RetroDECK/RetroDECK/issues/286), [RetroDECK/RetroDECK#427](https://github.com/RetroDECK/RetroDECK/issues/427).
