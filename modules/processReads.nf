process processReads {
    publishDir "${params.outdir}/sorted_aln_reads", pattern: '*.sam', mode: 'copy'

    input:
    tuple val(sample), path(raw_sam)
    val no_ref_seqs

    output:
    path "${sample}.sam"
    path "aln_summary.txt", emit: summary

    shell:
    '''
    #printf "sample\tref_seqs\tgene_length\tmapped_reads\tunmapped_reads\n" > "aln_summary.txt"
    ref_seq_lines=$(seq !{no_ref_seqs})
    printf "sample\n" > "aln_summary.txt"
    printf "!{sample}\n%0.s" ${ref_seq_lines}  >> "aln_summary.txt"
    #samtools sort "!{raw_sam}" -o "${sample}.sam"
    #paste -d "\t" <(printf "!{sample}\n%0.s" ${ref_seq_lines}) <(samtools idxstats "${sample}.sam") | head -n -1 >> "aln_summary.txt"
    '''
}