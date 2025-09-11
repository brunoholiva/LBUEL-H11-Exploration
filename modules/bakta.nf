#!/usr/bin/env nextflow

/*
 * Module: Bakta annotation
 * Inputs:
 *  - path genome: FASTA file
 *  - val  db: absolute path to Bakta DB (string, not copied)
 * Outputs:
 *  - path "<prefix>.bakta/<prefix>.gff3": GFF for Panaroo
 */

process BAKTA_ANNOTATE {
  label 'bakta'
  container 'oschwengers/bakta:v1.11.3'
  containerOptions '--entrypoint ""'
  tag { "Bakta on ${genome.baseName}" }

  input:
  path genome
  path bakta_db_dir

  output:
  path "${genome.baseName}.bakta/${genome.baseName}.gff3"

  script:
  def prefix = genome.baseName
  """
  bakta \\
    --db "${bakta_db_dir}" \\
    --output ${prefix}.bakta \\
    --prefix ${prefix} \\
    --skip-plot \\
    ${genome}
  """
}