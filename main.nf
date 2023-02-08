include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'
include { processReads } from './modules/processReads.nf'

workflow {
    // checking that index name and sample names (samples) are specified
    if (params.ref_name == "") {println("please specify reference name with --ref_name")}
    if (params.samples == "") {println("please specify name of samples with --samples")}

    // get the number of seqs in fasta reference
    no_ref_seqs=refs.countFasta()
    
    raw_sam_dir = file("${params.output_dir}/aln_reads")
    raw_sam_dir.mkdir()
    sorted_sam_dir = file("${params.output_dir}/sorted_aln_reads")
    sorted_sam_dir.mkdir()

    // main workflow
    index_ch = indexReference(params.ref_file,params.ref_name,params.index_dir)

    def sample_ch = Channel.of(params.samples)
    raw_sam_ch = alnReads(sample_ch, index_ch, params.fq_dir, params.output_dir)
    processed_sam = processReads(raw_sam_ch, params.output_dir, no_ref_seqs)

    processed_sam.out.summary.collectFile(name: "${params.output_dir}/aln_summary.txt", keepHeader: true, skip: 1)
}