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

  genomes_ch = Channel.fromPath(params.genomes).filter { it.isFile() }
  genomes_ch.ifEmpty { error "No genome FASTA files matched: ${params.genomes}" }

  // pass DB as a value (string), not copied
  def db_abs = file(params.bakta_db).toRealPath().toString()

  gff_ch = BAKTA_ANNOTATE(genomes_ch, db_abs)
  PANAROO_PAN_GENOME(gff_ch.collect())
}