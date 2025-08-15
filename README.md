
# LBUEL-H11-Exploration
This repository contains the exact code used to explore _Proteus mirabilis_ genomes for our paper. Shared for transparency and reproducibility.

## Data
All genomes were retrieved from NCBI's GenBank
Inclusion criteria: _Proteus mirabilis_ (scaffold or above), isolated from humans, and with CheckM ≥ 95% (GenBank). Total: 104 genomes (as of August 14, 2025).

## Annotation
All genomes were re-annotated with Bakta v1.11.3, database v6.0, for consistency.

## How to reproduce (so far)
1. Place genome files (`.fna`) in `proteus_strains/`.
2. Install Bakta and dependencies with conda (see `environment.yml`).
3. Run `annotation.py`.

This code is provided as a record of our methods for the paper.
