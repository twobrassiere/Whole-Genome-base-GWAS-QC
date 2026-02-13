#!/usr/bin/bash
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J DRAGEN         # Job name
#SBATCH -p ngs372G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 56            # 使用的core數 請參考Queue資源設定
#SBATCH --mem=372g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o out_concat.log          # Path to the standard output file
#SBATCH -e err_concat.log          # Path to the standard error ouput file
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=FAIL              # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

# Output directory should be same with the pervious step
output_dir=/staging/biology/elephant123/269_BC_GVCF_path
output_para=/staging/biology/elephant123/269_BC_GVCF
IGG_dir=/opt/ohpc/Taiwania3/pkg/biology/IGG/IGG_software_build_v4.0.3_and_local_demo/
dragen=$(realpath $IGG_dir/install/bin/dragen)
ref_fasta=$(realpath $IGG_dir/ref/hg38.fa)
config_dir=$IGG_dir/config
num_shards=102
ulimit -n 65535
ulimit -u 16384
ml load biology
module load bcftools/1.13

for shard in $(seq 1 $num_shards); do
	realpath $output_dir/shard-$shard/dragen.vcf.gz
done > concat.list

bcftools concat \
	--naive-force \
	--no-version \
	-Oz \
	-o $output_para.vcf.gz \
	-f concat.list
bcftools index -t -f $output_para.vcf.gz --threads 56
