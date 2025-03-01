process FILTER_BAM_10X {
  tag "${chr}, ${bamFileID}"
  label 'process_medium'

  conda 'bioconda::pysam=0.17.0 python=3.7'

  input:
  tuple val(inputChannel), val(bamFileID), path(bam), path(bai)
  val isSICILIAN
  val isCellranger
  val libType
  each chr

  output:
  path "*.filter", emit: filter

  script:
  """
  filter.py \\
    --input_bam <(samtools view -b ${bam} ${chr} ) \\
    --isSICILIAN ${isSICILIAN} \\
    --isCellranger ${isCellranger} \\
    --libType ${libType} \\
    --bamName ${bamFileID} \\
    --inputChannel ${inputChannel} \\
    --chr ${chr}
  """
}
