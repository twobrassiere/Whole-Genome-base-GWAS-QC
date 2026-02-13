#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J filter_remove_1000G
#SBATCH -p ngs4T_72
#SBATCH -c 72
#SBATCH --mem=4000g
#SBATCH -o /staging/biology/elephant123/concat_out.log
#SBATCH -e /staging/biology/elephant123/concat_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END

# step1 concat Phased 1000G hg38 dragen in each chromsome
ml load biology
ml load BCFtools/1.18
bcftools concat \
--naive-force \
--no-version \
-Oz \
-o /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample.vcf.gz \
-f /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample.list

bcftools index -t -f \
/staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample.vcf.gz  \
--threads 56

# step2 Filter by call rate > 95% in Phased 1000G hg38 dragen
bcftools view \
    -i 'F_MISSING < 0.05' \
    -Oz /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample.vcf.gz \
    -o /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/filter_call_ratet_by_phase_1000G_sample.vcf.gz \
    --threads 56

bcftools index -t -f \
    /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/filter_call_ratet_by_phase_1000G_sample.vcf.gz  \
    --threads 56
