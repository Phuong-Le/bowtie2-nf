process indexReference {
    input:
        path refs
        path index_dir 
        val ref_name
    

    script:
        """
        cd $index_dir
        bowtie2-build $refs $ref_name
        """
}