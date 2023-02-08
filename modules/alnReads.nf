process alnReads {
    input:
        val sample
        tuple val(ref_name), path(index_dir)
        path fq_dir
        path output_dir

    output:
        tuple val(sample) path(raw_sam)

    script:
        raw_sam="${output_dir}/aln_reads/${sample}.sam"
        sample1="${fq_dir}/${sample}-R1.fastq"
        sample2="${fq_dir}/${sample}-R2.fastq"

        """
        cd ${index_dir}]
        # mkdir -p "${output_dir}/aln_reads" "${output_dir}/sorted_aln_reads"

        bowtie2 -x ${ref_name} -1 ${sample1} -2 ${sample2} --no-unal -S ${raw_sam}
        """
}