#!/usr/bin/bash
#SBATCH -A MST109178        # Account name/project number
#SBATCH -J igg_single_batch_by_269_BC        # Job name
#SBATCH -p ngs186G           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 28              # 使用的core數 請參考Queue資源設定
#SBATCH --mem=186g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 269_BC.out_dragen.log          # Path to the standard output file
#SBATCH -e 269_BC.err_dragen.log          # Path to the standard error ouput file
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END              # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

# Below parameters should be modified
# List of samples to perform gvcf-genotyper
output_dir=/staging/biology/elephant123/269_BC_GVCF_path
gg_remove_nonref=true
gg_discard_ac_zero=true


IGG_dir=/opt/ohpc/Taiwania3/pkg/biology/IGG/IGG_software_build_v4.0.3_and_local_demo/
dragen=$(realpath $IGG_dir/install/bin/dragen)
ref_fasta=/staging/biology/elephant123/GATK/DRAGEN_hg38/hg38.fa
config_dir=$IGG_dir/config
num_threads=28
num_shards=102
ulimit -n 71812
ulimit -u 16384
module load biology/bcftools/1.13
mkdir -p $output_dir

shard=$1
shard_dir=$output_dir/shard-$shard
rm -rf $shard_dir
mkdir -p $shard_dir

$dragen \
    --sw-mode \
    --enable-gvcf-genotyper-iterative true \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010001WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010002WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010003WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010004WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010005WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010006WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010007WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010008WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010009WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010010WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010011WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010012WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010013WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010014WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010015WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010016WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010017WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010018WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010019WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010020WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010021WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010022WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010023WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010024WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010025WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010026WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010027WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010028WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010029WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010030WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010031WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010032WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010033WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010034WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010035WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010036WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010037WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010038WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010039WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010040WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010041WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010042WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010043WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010044WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010045WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010046WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010047WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010048WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010049WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010050WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010051WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010052WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010053WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010054WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010055WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010056WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010057WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010058WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010059WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010060WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010061WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010062WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010063WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010064WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010065WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010066WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010067WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010068WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010069WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010070WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010071WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010072WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010073WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010074WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010075WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010076WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010077WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010078WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010079WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010080WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010081WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010082WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010083WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010084WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010085WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010086WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010087WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010088WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010089WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010090WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010091WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010092WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010093WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010094WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010095WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010096WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010097WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010098WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010099WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010100WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010101WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010102WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010103WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010104WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010105WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010106WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010107WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010108WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010109WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010110WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010111WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010112WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010113WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010114WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010115WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010116WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010117WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010118WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010119WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010120WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010121WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010123WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010124WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010125WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010126WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010127WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010128WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010129WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010130WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010131WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010132WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010133WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010134WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010135WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010136WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010137WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010138WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010139WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010140WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010141WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010142WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010143WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010144WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010145WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010146WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010147WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010148WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010149WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010150WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010151WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010152WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010153WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010154WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010155WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010156WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010157WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010158WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010159WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010160WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010161WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010162WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010163WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010164WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010165WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010166WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010167WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010168WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010169WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010170WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010171WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010172WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010173WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010174WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010175WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010176WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010177WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010178WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010179WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010180WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010181WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010182WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010183WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010184WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010185WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010186WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010187WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010188WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010189WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010190WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010191WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010192WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010193WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010194WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010195WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010196WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010197WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010198WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010199WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010200WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010201WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010202WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010203WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010204WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010205WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010206WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010207WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010208WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010209WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010210WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010211WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010212WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010213WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010214WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010215WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010216WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010217WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010218WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010219WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010220WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010221WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010222WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010223WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010224WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010225WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010227WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010228WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010229WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010230WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010231WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010232WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010233WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010234WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010235WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010236WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010237WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010238WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010239WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010240WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010241WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010242WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010243WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010244WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010245WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010246WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010247WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010248WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010249WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010250WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010251WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010252WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010253WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010254WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010255WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010256WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010257WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010258WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010259WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010260WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010261WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010262WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010263WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010264WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010265WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010266WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010267WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010268WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010269WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010270WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --variant  /staging/biology/elephant123/269_BC_GVCF/I010271WGSB00_dragen_v4.2.4_hs38DH_graph.hard-filtered.gvcf.gz  \
    --shard $shard/$num_shards \
    --num-threads $num_threads \
    --logging-to-output-dir true \
    --output-directory $shard_dir \
    --ht-reference $ref_fasta \
    --gg-remove-nonref $gg_remove_nonref \
    --gg-discard-ac-zero $gg_discard_ac_zero
