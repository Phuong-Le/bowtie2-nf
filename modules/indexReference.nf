process indexReference {
    input:
    path ref_file
    path index_file

    output:
    // tuple val(ref_name), path(index_dir)
    path indices

    script:
    ref_name = index_file.getBaseName()
    indices = "${ref_name}.*"
    println ref_name
    """
    bowtie2-build ${ref_file} ${ref_name}
    """

}