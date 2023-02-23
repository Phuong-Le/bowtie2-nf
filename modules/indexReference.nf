process indexReference {
    input:
    path ref_file
    path index_dir
    val ref_name


    output:
    path index_dir

    script:
    index_prefix = "${index_dir}/${ref_name}"
    """
    bowtie2-build ${ref_file} ${index_prefix}
    """

}