process alnReads {
    input:
        val sample
        tuple val(ref_name), path(index_dir)
        path fq_dir
        path outdir

    output:
        tuple val(sample) path(raw_sam)

    script:
        raw_sam="${outdir}/aln_reads/${sample}.sam"
        sample1="${fq_dir}/${sample}-R1.fastq"
        sample2="${fq_dir}/${sample}-R2.fastq"

        """
        cd ${index_dir}]
        # mkdir -p "${outdir}/aln_reads" "${outdir}/sorted_aln_reads"

        bowtie2 -x ${ref_name} -1 ${sample1} -2 ${sample2} --no-unal -S ${raw_sam}
        """
}