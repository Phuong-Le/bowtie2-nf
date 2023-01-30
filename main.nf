include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'

workflow bowtie2Mapping {
    \\ checking that index name and sample names (samples) are specified
    if (params.ref_name == "") {println("please specify reference name with --ref_name")}
    if (params.samples == "") {println("please specify name of samples with --samples")}

    \\ main workflow
    indexReference()
    def sanple_ch = Channel.of(params.samples)
    alnReads(sample_ch)
}