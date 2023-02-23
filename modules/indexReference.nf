process indexReference {
    publishDir "${params.index_dir}", mode: 'copy'

    input:
    path ref_file
    path index_file

    output:
    path indices

    script:
    ref_name = index_file.getBaseName()
    indices = "${ref_name}.*"
    """
    bowtie2-build ${ref_file} ${ref_name}
    """

}