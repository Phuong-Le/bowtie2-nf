process alnReads {
    input:
        val sample

    script:
        """
        cd $params.index_dir 
        mkdir -p ${params.output_dir}/aln_reads ${params.output_dir}/sorted_aln_reads

        sample1="${params.input_dir}/${sample}-R1.fastq"
        sample2="${params.input_dir}/${sample}-R2.fastq"

        bowtie2 -x $params.ref_name -1 $sample1 -2 $sample2 --no-unal -S ${params.output_dir}/aln_reads/${sample}.sam
        samtools sort ${params.output_dir}/aln_reads/${params.sample}.sam -o ${params.output_dir}/sorted_aln_reads/${sample}.sam
        """
}