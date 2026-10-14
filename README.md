# test_data3

Model output of the WRF rebuild of Branch et al. (2024), black surfaces and desert rain in the UAE:
2 runs, 4.44 GB. The write-up, code and results are in the
repository `test_data` (parts 1–4); `branch2024_data/DATA_README.md` describes the whole data set.

| Run | GB |
|---|---|
| `D3_veryunstable_square40_iso` | 3.86 |
| `D3_veryunstable_drcb40` | 0.58 |

## Getting a working copy

Clone on Linux or macOS. Some file names contain `:`, which Windows can't store.

```
git clone https://github.com/vtbatman/test_data3.git
cd test_data3
./restore.sh /path/on/nas/branch2024_data
```

Use the same destination for every repository of this data set. `restore.sh` copies the data out of
the clone, joins the files stored in 95 MiB pieces, and checks every file this repository holds
(`CONTENTS.txt`) against the MD5 sums in `MANIFEST.csv`. It should end with
`... files verified, 0 problems`.
