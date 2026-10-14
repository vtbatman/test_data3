# Data of the Branch et al. (2024) rebuild

6674 entries in 25 parts, 28.1 GB in all. The code, write-up and results are in `branch2024_rebuild.zip` (part 1); `README.md` and `TODO.md` are next to it.

## Unpacking

```
for f in branch2024_data_part*.tar; do tar -xf "$f"; done        # whole files
# files larger than a part come as pieces; join each set in order, e.g.
cat branch2024_data/<path>.piece1of3 branch2024_data/<path>.piece2of3 branch2024_data/<path>.piece3of3 > branch2024_data/<path>
python3 branch2024_data/verify_data.py                          # checks every file against MANIFEST.csv
```

Pieces are delivered as `branch2024_data_partNN_piece.tar`, each holding one `<path>.pieceKofN`.

From a git repository instead of tar parts: GitHub takes files of at most 100 MiB, so larger files
are stored as pieces of 95 MiB, joined the same way with `cat` (the repository's README lists the
commands). `python3 branch2024_data/verify_data.py 1 2` then checks only parts 1 and 2.

## What is in it

- `idealized/runs/<run>/`: one directory per model run. Its settings are in `case_info.txt`, `namelist.input`,
  `abs_layout.txt`, `abs_panels.txt` and `input_sounding`; `RUNS.csv` collects them. The model output is in
  `wrfout_d01_*` (netCDF-4, zlib-compressed). `wrfout_thin_*` holds surface fields only, for runs whose full
  output was reduced; their analysis is cached in `analysis_cache.pkl` and `bl_theta.txt`.
- **What was reduced to save space in the workspace** (the analysis numbers are unaffected):
  - 2D runs `RS_ RP_ RG_ RX_ RE_ RT_`: surface fields only, plus the analysis caches.
  - 3D runs `D3P_`: 3D fields up to about 6 km (61 of 100 levels). `D3P_AEM00041217_2015090500_black` also
    lacks V, P and QCLOUD.
  - Everything else is complete. `D3_unstable_square40` was converted losslessly from classic to netCDF-4.
- `idealized/results/`: the tables (CSV), series (NPZ) and figures of the write-up.
- `realworld/data*/soundings/`: the Abu Dhabi radiosondes used, with stability summaries.
- `spectral_data/`: measured spectra, optical constants and the band files of the surface materials.

## Parts

| Part | Group | Files | GB |
|---|---|---|---|
| 1 | docs_results_soundings_realruns | 3391 | 0.50 |
| 2 | real_sounding_runs | 2115 | 0.80 |
| 3 | 3d_panel_runs | 97 | 1.55 |
| 4 | 3d_panel_runs | 133 | 1.55 |
| 5 | 2d_constructed_runs | 99 | 1.43 |
| 6 | 2d_constructed_runs | 102 | 1.57 |
| 7 | 2d_constructed_runs | 117 | 1.53 |
| 8 | 2d_constructed_runs | 108 | 1.55 |
| 9 | 2d_constructed_runs | 87 | 1.42 |
| 10 | 2d_constructed_runs | 91 | 1.43 |
| 11 | 2d_constructed_runs | 101 | 1.43 |
| 12 | 2d_constructed_runs | 19 | 0.46 |
| 13 | 3d_constructed_runs | 67 | 1.56 |
| 14 | 3d_constructed_runs | 44 | 1.54 |
| 15 | 3d_constructed_runs | 27 | 0.51 |
| 16 | 3d_constructed_runs | 1 | 1.57 |
| 17 | 3d_constructed_runs | 1 | 0.47 |
| 18 | 3d_constructed_runs | 13 | 0.01 |
| 19 | 3d_constructed_runs | 1 | 1.57 |
| 20 | 3d_constructed_runs | 1 | 1.57 |
| 21 | 3d_constructed_runs | 1 | 0.70 |
| 22 | 3d_constructed_runs | 12 | 0.00 |
| 23 | 3d_constructed_runs | 1 | 1.57 |
| 24 | 3d_constructed_runs | 1 | 0.47 |
| 25 | 3d_constructed_runs | 44 | 1.37 |
