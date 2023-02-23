process alnReads {
    publishDir "${params.outdir}/aln_reads", mode: 'copy'

    input:
    val indices // this variable won't be used, it is included as part of the pipe 
    path index_file
    tuple val(sample), path(fq1), path(fq2) 

    output:
    tuple val(sample), path("${sample}.sam")
    
    script:
    ref_name = "${index_file.getParent()}/${index_file.getBaseName()}"
    """
    bowtie2 -x ${ref_name} -1 ${fq1} -2 ${fq2} --no-unal -p 12 -S "${sample}.sam"
    """
}