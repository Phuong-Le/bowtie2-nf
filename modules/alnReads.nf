process alnReads {
    input:
        val indices
        val ref_name
        tuple val(sample), path(fq1), path(fq2)
        path outdir

    output:
        tuple val(sample) path(raw_sam)

    script:
        raw_sam="${outdir}/aln_reads/${sample}.sam"
        """
        #bowtie2 -x ${ref_name} -1 ${fq1} -2 ${fq2} --no-unal -S ${raw_sam}
        """
}