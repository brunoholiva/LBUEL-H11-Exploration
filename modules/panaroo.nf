#!/usr/bin/env nextflow

/*
 * Module: Panaroo pangenome
 * Inputs:
 *  - path gff_files: collection of GFF3 files (from collect())
 * Outputs:
 *  - path "panaroo_out/*": Panaroo outputs
 */

process PANAROO_PAN_GENOME {
  label 'panaroo'
  container 'staphb/panaroo:1.5.2'
  publishDir "${params.outdir}/panaroo/", mode: 'copy'
  tag { "Panaroo core-genome" }
  cpus 10

  input:
  path gff_files

  output:
  path "panaroo_out/*"
  script:
  """
  mkdir -p panaroo_out
  panaroo -i *.gff3 --clean-mode strict -t ${task.cpus} -o panaroo_out --remove-invalid-genes -a pan
  """
}

