#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'
include { processReads } from './modules/processReads.nf'

workflow {
    // get the number of seqs in fasta reference
    // no_ref_seqs = file(params.ref_file).countFasta()

    // raw_sam_dir = file("${params.outdir}/aln_reads")
    // raw_sam_dir.mkdir()
    // sorted_sam_dir = file("${params.outdir}/sorted_aln_reads")
    // sorted_sam_dir.mkdir()

    // main workflow
    // getting index files 
    index1 = file("${params.index_dir}/${params.ref_name}.1.bt2")
    index2 = file("${params.index_dir}/${params.ref_name}.2.bt2")
    index3 = file("${params.index_dir}/${params.ref_name}.3.bt2")
    index4 = file("${params.index_dir}/${params.ref_name}.4.bt2")
    index5 = file("${params.index_dir}/${params.ref_name}.rev.1.bt2")
    index6 = file("${params.index_dir}/${params.ref_name}.rev.2.bt2")
    if (index1.exists() && index2.exists() && index3.exists() && index4.exists() && index5.exists() && index6.exists()) {
        println "indices exist, proceed to alignment"
    } else {
        index_ch = indexReference(params.ref_file, params.ref_name)
    }

    // def sample_ch = Channel.of(params.samples)
    // raw_sam_ch = alnReads(sample_ch, index_ch, params.fq_dir, params.outdir)
    // processed_sam = processReads(raw_sam_ch, params.outdir, no_ref_seqs)

    // processed_sam.out.summary.collectFile(name: "${params.outdir}/aln_summary.txt", keepHeader: true, skip: 1)
}