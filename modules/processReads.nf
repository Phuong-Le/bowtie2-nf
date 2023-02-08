process processReads {
    input:
    // the raw sam
        tuple val(sample) path(raw_sam)
        path output_dir
        val no_ref_seqs

    output:
    // sorted sam 
    // summary file, emit summary
        path summary_file, emit: summary

    shell:
    sorted_dir = "${output_dir}/sorted_aln_reads"
    sorted_sam = "${output_dir}/sorted_aln_reads/${sample}.sam"
    summary_file =  "${output_dir}/aln_summary.txt"
    '''
    printf "sample\tref_seqs\tgene_length\tmapped_reads\tunmapped_reads\n" > !{summary_file}
    ref_seq_lines=$(seq !{no_ref_seqs})
    samtools sort "!{output_dir}/aln_reads/!{sample}.sam" -o !{sorted_sam}
    paste -d "\t" <(printf "!{sample}\n%0.s" $ref_seq_lines) <(samtools idxstats !{sorted_dir}/!{sample}.sam) | head -n -1 >> !{summary_file}
    '''
}