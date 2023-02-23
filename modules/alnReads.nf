process alnReads {
    publishDir "${params.outdir}/aln_reads", mode: 'copy'

    input:
    path index_dir
    val ref_name
    tuple val(sample), path(fq1), path(fq2) 

    output:
    tuple val(sample), path("${sample}.sam")
    
    script:
    index_prefix = "${index_dir}/${ref_name}"
    """
    bowtie2 -x ${index_prefix} -1 ${fq1} -2 ${fq2} --no-unal -p 12 -S "${sample}.sam"
    """
}