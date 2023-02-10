process indexReference {
    input:
    path ref_file
    val ref_name

    output:
    // tuple val(ref_name), path(index_dir)
    path indices

    script:
    indices = "${ref_name}.*"
    """
    bowtie2-build ${ref_file} ${ref_name}
    """

}