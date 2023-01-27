process alnReads {
    input:
        path index_dir
        val index_name
        path input_dir
        val sample
        path output_dir


    """
    cd $index_dir 
    mkdir -p ${output_dir}/aln_reads

    sample1="${input_dir}/${sample}-R1.fastq"
    sample2="${input_dir}/${sample}-R2.fastq"

    bowtie2 -x $index_name -1 $sample1 -2 $sample2 --no-unal -p 12 -S ${output_dir}/aln_reads/${sample}.sam
    """
}