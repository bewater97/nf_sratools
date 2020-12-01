#!/usr/bin/env nextflow

def helpMessage() {
    log.info"""
    *********************************************************************************************
    *********************************************************************************************
    Pipeline INFO: NCBI_SRA download_v1_20201130

    usage: 
    nextflow run download.nf --input sra.list 

    optional arguments:
    --input [file]        Path to sralist (Default:launchDir/'sra.list', must be abspath)
    --output [dir]        Path to output dir (Default:launchDir, must be abspath)
    -N                    Send Email after all process completed
    -profile cluster	  using (-profile cluster) (run in cluster mode)
    *********************************************************************************************
    *********************************************************************************************
    """.stripIndent()
}
params.help = ''
if (params.help) {
    helpMessage()
    exit 0
}

params.input=launchDir/'sra.list'
params.output=launchDir

process sra_download {

executor 'local'
publishDir "$params.output",mode : 'link'

input:

output:
file ('*/*sra') into sra_files
script:
"""
prefetch --option-file $params.input
""" 

}

process sra_split{

publishDir "$params.output", mode: 'move'

input:
val sra_file from sra_files.flatten()

output:
file ('*fastq') 
stdout into result

script:
"""
echo ${sra_file.baseName} 
fastq-dump --split-e $sra_file
rm $sra_file
"""
}

process move_fastq{

echo true

input:  
val sra_id from sra_files.flatten()
val sra_log from result
output: 

script:
"""
echo "${sra_log}" > $params.output/${sra_id.baseName}/${sra_id.baseName}.log
mv $params.output/${sra_id.baseName}*.fastq $params.output/${sra_id.baseName}
"""
}
