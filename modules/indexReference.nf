process indexReference {
    
    script:
        """
        cd $params.index_dir
        bowtie2-build $params.refs $params.ref_name
        """
}