process indexReference {
    input:
        path ref_file
        val ref_name
        path index_dir

    output:
        tuple val(ref_name), path(index_dir)

    script:
        """
        cd ${index_dir}
        bowtie2-build ${ref_file} ${ref_name}
        """
}