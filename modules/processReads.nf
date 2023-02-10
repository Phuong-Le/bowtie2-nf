process processReads {
    input:
    // the raw sam
        tuple val(sample) path(raw_sam)
        path outdir
        val no_ref_seqs

    output:
    // sorted sam 
    // summary file, emit summary
        path summary_file, emit: summary

    shell:
        sorted_dir = "${outdir}/sorted_aln_reads"
        sorted_sam = "${outdir}/sorted_aln_reads/${sample}.sam"
        summary_file =  "${outdir}/aln_summary.txt"
        '''
        printf "sample\tref_seqs\tgene_length\tmapped_reads\tunmapped_reads\n" > !{summary_file}
        ref_seq_lines=$(seq !{no_ref_seqs})
        samtools sort "!{outdir}/aln_reads/!{sample}.sam" -o !{sorted_sam}
        paste -d "\t" <(printf "!{sample}\n%0.s" $ref_seq_lines) <(samtools idxstats !{sorted_dir}/!{sample}.sam) | head -n -1 >> !{summary_file}
        '''
}