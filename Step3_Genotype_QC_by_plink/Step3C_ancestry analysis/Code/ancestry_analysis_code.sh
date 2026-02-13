#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J TWB_merge_269_BC_in_1000G
#SBATCH -p ngs4T_72
#SBATCH -c 72
#SBATCH --mem=4000g
#SBATCH -o /staging/biology/elephant123/1000G_dragen/star_out.log
#SBATCH -e /staging/biology/elephant123/1000G_dragen/star_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END
#Step9. merge our data and 1000G dragen dataset

#Step1  convert vcf to pfiles
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_16Aug/plink2 \
--vcf /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/filter_call_ratet_by_phase_1000G_sample.vcf.gz \
--make-pfile --out /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample \
--threads 56
#Step2  Remove duplicate SNPs in 1000G use plink2
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2 \
--pfile /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample \
--rm-dup exclude-all \
--make-bed --out /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample_repeat_id \
--set-all-var-ids @:#

#Step3 Remove merge dataset of  snp
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample_repeat_id \
--keep-allele-order \
--bmerge /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--make-bed \
--out /staging/biology/elephant123/1000G_dragen/TWB_merge_266_BC_in_1000G  \
--threads 72
#Step4 Remove 1000G and our data both variant
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--exclude /staging/biology/elephant123/1000G_dragen/TWB_merge_266_BC_in_1000G-merge.missnp \
--make-bed \
--out /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_qc_finlish-tmp

/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/u00phl00/Research/Original_Data/1000G_hg38_dragen/Phase_1000G_sample_repeat_id \
--exclude /staging/biology/elephant123/1000G_dragen/TWB_merge_266_BC_in_1000G-merge.missnp \
--make-bed \
--out /staging/biology/elephant123/1000G_dragen/Phase_1000G_sample_repeat_id-tmp \
--threads 72

/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_qc_finlish-tmp \
--keep-allele-order \
--bmerge /staging/biology/elephant123/1000G_dragen/Phase_1000G_sample_repeat_id-tmp \
--make-bed \
--out /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G \
--threads 72


#Step 5 pca in our data merge
# Find strand ambiguous SNPs
python2 find_atgc_snps.py \
/staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.bim > \
/staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.atgc.snplist

# Write a list of non-strand ambiguous SNPs to keep
awk 'NR==FNR{a[$1];next} !($2 in a) {print $2}' \
/staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.atgc.snplist \
/staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.bim > \
/staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.non-atgc.snplist


# Perform LD pruning
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G \
--autosome \
--geno 0.02 \
--maf 0.05 \
--snps-only just-acgt \
--extract /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.non-atgc.snplist \
--exclude range long_range_LD_intervals.txt \
--indep-pairwise 200 100 0.1 \
--out /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G-ldpr \
--threads 72


# Run pca
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G  \
--extract /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G-ldpr.prune.in \
--pca 20 header tabs \
--out /staging/biology/elephant123/1000G_dragen/TWB_merge_269_BC_in_1000G.pca \
--threads 72
