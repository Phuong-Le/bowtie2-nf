process indexReference {
    input:
    path ref_file
    path index_dir
    val ref_name

    output:
    tuple val(ref_name), path(index_dir)

    script:
    index1 = "${index_dir}/${ref_name}.1.bt2"

    // def test_file = file(index1)
    // index2 = file("${index_dir}/${ref_name}.2.bt2")
    // index3 = file("${index_dir}/${ref_name}.3.bt2")
    // index4 = file("${index_dir}/${ref_name}.4.bt2")
    // index5 = file("${index_dir}/${ref_name}.rev.1.bt2")
    // index6 = file("${index_dir}/${ref_name}.rev.2.bt2")
    // if ( index1.exists() ) {println "index1 exists"}
    // else {println "file not found"}
    if ( ref_file.exists() ) 
        """
        echo "bowtie2 index already built, proceed with alignment" > "${params.output_dir}/index_refs.txt"
        """
    
    else 
        """
        echo "building bowtie2 index" > "${params.output_dir}/index_refs.txt"
        """

}