process alnReads {
    publishDir "${params.outdir}/aln_reads", mode: 'copy'

    input:
    val indices // this variable won't be used, it is included as part of the pipe 
    val ref_name
    tuple val(sample), val(fq1), val(fq2) // remember to change val to path when actually running samtools

    output:
    path "${sample}.sam", emit: sam

    script:
    """
    echo "${fq1} and ${fq2} have been processed" > "${sample}.sam"
    bowtie2 -x ${ref_name} -1 ${fq1} -2 ${fq2} --no-unal -p 12 -S "${sample}.sam"
    """
}