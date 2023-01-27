include { indexReference } from './modules/indexReference.nf'
include { alnReads } from './modules/alnReads.nf'

workflow bowtie2Mapping {
    indexReference
}