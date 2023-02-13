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
    ref_seq_lines=$(seq !{no_ref_seqs})
    printf "!{sample}\n" > "aln_summary.txt"
    printf "!{sample}\n%0.s" ${ref_seq_lines}  >> "aln_summary.txt"
    '''
}