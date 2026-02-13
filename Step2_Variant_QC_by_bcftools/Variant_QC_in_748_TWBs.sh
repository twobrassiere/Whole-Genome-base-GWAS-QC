#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J filtered_confidence_regions_of_hg38_in_269BC
#SBATCH -p ngs6T_112
#SBATCH -c 112
#SBATCH --mem=6000g
#SBATCH -o /staging/biology/elephant123/filtered_out.log
#SBATCH -e /staging/biology/elephant123/filtered_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END

# 1. Filter by confidence regions
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools view \
    -R /staging/biology/u00phl00/ref/GATK/Hg38/HG002_GRCh38_1_22_v4.2.1_benchmark_noinconsistent.bed \
    -Oz /staging/biology/elephant123/748_TWB_GVCF.vcf.gz \
    -o /staging/biology/elephant123/filtered_confidence_regions_by_748_TWB_in_IGG.vcf.gz \
    --threads 112
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools index -t -f \
   /staging/biology/elephant123/filtered_confidence_regions_by_748_TWB_in_IGG.vcf.gz --threads 112
# 2. Split and left-align multi-allelic variants
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools norm \
    -m -any \
    -f /work/opt/ohpc/Taiwania3/pkg/biology/IGG/IGG_software_build_v4.0.3_and_local_demo/ref/hg38.fa \
    -Oz /staging/biology/elephant123/filtered_confidence_regions_by_270_BC_in_IGG.vcf.gz \
    -o /staging/biology/elephant123/269_bc_and_748_TWB/split_and_left-align_multi-allelic_variant_by_748_TWB_in_hg38_ICC.vcf.gz \
    --threads 112

# 3. Index the normalized VCF
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools index -t -f \
   /staging/biology/elephant123/269_bc_and_748_TWB/split_and_left-align_multi-allelic_variant_by_748_TWB_in_hg38_ICC.vcf.gz --threads 112


# 4. Filter by call rate > 95%
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools view \
    -i 'F_MISSING < 0.02' \
    -Oz /staging/biology/elephant123/269_bc_and_748_TWB/split_and_left-align_multi-allelic_variant_by_748_TWB_in_hg38_ICC.vcf.gz \
    -o /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB.vcf.gz \
    --threads 112
/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools index -t -f \
     /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB.vcf.gz  --threads 112

/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools merge \
-Oz /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB.vcf.gz \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC.vcf.gz \
-o /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB.vcf.gz \
--threads 112

/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools index -t -f \
      /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB.vcf.gz \
        --threads 112
