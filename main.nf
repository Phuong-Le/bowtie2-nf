include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'

workflow {
    // checking that index name and sample names (samples) are specified
    if (params.ref_name == "") {println("please specify reference name with --ref_name")}
    if (params.samples == "") {println("please specify name of samples with --samples")}

    // get the number of seqs in fasta reference
    // no_ref_seqs=refs.countFasta()
    
    // mkdir for raw sam and sorted sam "${output_dir}/aln_reads/${sample}.sam" "${output_dir}/sorted_aln_reads/${sample}.sam"
    raw_sam_dir = file("${params.output_dir}/aln_reads")
    raw_sam_dir.mkdir()
    sorted_sam_dir = file("${params.output_dir}/sorted_aln_reads")
    sorted_sam_dir.mkdir()

    // main workflow
    indexReference()
    def sample_ch = Channel.of(params.samples)
    alnReads(sample_ch)
}