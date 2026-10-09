# Upstream

| | |
| --- | --- |
| Project | XBOW validation benchmarks |
| Repository | https://github.com/xbow-engineering/validation-benchmarks |
| Benchmark | `benchmarks/XBEN-092-24` (SKU service) |
| Version | main (the repository has no releases) |
| Commit | a16cb1ba0701b20d63913846536fc7b0672082af |
| Licence | Apache-2.0 (LICENSE and NOTICE at the repository root, copied here) |

| Here | validation-benchmarks path |
| --- | --- |
| `build/web/app/` | [`benchmarks/XBEN-092-24`](https://github.com/xbow-engineering/validation-benchmarks/tree/a16cb1ba0701b20d63913846536fc7b0672082af/benchmarks/XBEN-092-24) except `app/skumodel-srv/` |
| `build/skumodel/app/` | [`benchmarks/XBEN-092-24/app/skumodel-srv`](https://github.com/xbow-engineering/validation-benchmarks/tree/a16cb1ba0701b20d63913846536fc7b0672082af/benchmarks/XBEN-092-24/app/skumodel-srv) |

The vendored folders are that commit's benchmark folder, unchanged, without its Git history, canary
strings included. The flag is the one upstream's Makefile builds with (`common.mk`: `FLAG{` + the
SHA-256 of `XBEN-092-24` + `}`), passed there as the `FLAG` build argument; Isoloom builds without build
arguments, so the overlay `build/skumodel/Dockerfile` (the benchmark's `app/skumodel-srv/Dockerfile`, its COPY sources
pointed into `app/`) makes that value the argument's default.

The other machines:

- `web`: `build/web/Dockerfile`, the benchmark's `app/Dockerfile` with its COPY sources pointed into `app/app/` and apt
  reading archive.debian.org (its php:8.0 Debian bullseye base no longer installs from the Debian mirrors). Its web
  root no longer carries a copy of `skumodel-srv/` (see the header comment).

To update, replace the vendored folder with a newer commit's benchmark folder, then change this file.
