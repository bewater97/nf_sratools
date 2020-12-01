```
基于Nextflow的流程，用于下载NCBI_SRA数据：
使用方法：
git clone https://github.com/bewater97/nf_sratools
只需要修改 nextflow.config，配置邮箱信息，其他使用方法见下。
```
```
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
```
