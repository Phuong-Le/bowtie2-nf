process processReads {
    input:
    // the unsorted sam
    // path sam
    
    output:
    // sorted sam 
    // summary file, emit summary

    script:
    """
    samtools sort "${output_dir}/aln_reads/${sample}.sam" -o ${sorted_sam}
    paste -d "\t" <(printf "${sample}\n%0.s" $ref_seq_lines) <(samtools idxstats ${sorted_dir}/${sample}.sam) | head -n -1 >> ${summary_file}
    """
}