#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { BAKTA_ANNOTATE     } from './modules/bakta.nf'
include { PANAROO_PAN_GENOME } from './modules/panaroo.nf'

workflow {
  if (params.help) {
    log.info """
    Simple pangenome pipeline (Bakta -> Panaroo)
    Usage:
      nextflow run main.nf --genomes '<path/*.fna>' --bakta_db /path/to/db [--outdir results]
    """
    return
  }

  genomes_ch = Channel.fromPath(params.genomes)
  bakta_db_ch = Channel.value(params.bakta_db_dir)


  gff_ch = BAKTA_ANNOTATE(genomes_ch, bakta_db_ch)
  PANAROO_PAN_GENOME(gff_ch.collect())
}