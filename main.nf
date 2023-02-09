#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'
include { processReads } from './modules/processReads.nf'

workflow {
    // get the number of seqs in fasta reference
    no_ref_seqs = file(params.ref_file).countFasta()

    // raw_sam_dir = file("${params.output_dir}/aln_reads")
    // raw_sam_dir.mkdir()
    // sorted_sam_dir = file("${params.output_dir}/sorted_aln_reads")
    // sorted_sam_dir.mkdir()

    // main workflow
    // the conditional expression should be in the main workflow as process won't take dir in the form of absolute path
    // if params.index_dir/params.ref_name exists then index_ch = tuple of index dir and ref name
    // else indexReference
    index_ch = indexReference( params.ref_file, params.index_dir, params.ref_name )
    index_ch.view()
    // def sample_ch = Channel.of(params.samples)
    // raw_sam_ch = alnReads(sample_ch, index_ch, params.fq_dir, params.output_dir)
    // processed_sam = processReads(raw_sam_ch, params.output_dir, no_ref_seqs)

    // processed_sam.out.summary.collectFile(name: "${params.output_dir}/aln_summary.txt", keepHeader: true, skip: 1)
}