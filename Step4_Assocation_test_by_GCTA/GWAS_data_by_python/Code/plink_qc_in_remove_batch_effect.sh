#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J plink_qc_remove_bias_effect_in_270_BC
#SBATCH -p ngs3T_56
#SBATCH -c 56
#SBATCH --mem=3000g
#SBATCH -o /staging/biology/elephant123/PCA_out.log
#SBATCH -e /staging/biology/elephant123/PCA_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END
ml load biology
ml load BCFtools/1.18

#Step1-1 filter call ratet by 270 BC convert plink format
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2  \
--vcf /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC.vcf.gz \
--snps-only \
--recover-var-ids /staging/biology/u00phl00/ref/GATK/Hg38/dbsnp157.vcf.gz force partial \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--threads 56

#Step2-1 Output a list of SNPs with call rate > 0.98 in 270 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC  \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02

#Step3-1 Filter to SNPs in the previous step, output a list of samples with call rate > 0.98 in 270 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02.snplist \
--missing \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02

awk 'NR>1{if($6<0.02){print $1,$2}}' \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02.imiss  > \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02.indlist

#Step4-1 Filter to samples in the previous step, output a list of SNPs with call rate > 0.98 in 270 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02.indlist \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02_geno02

#Step5-1. Keep samples and SNPs passing previous filters, calculate SNP-level missing rate in 270 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02.indlist \
--missing \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02_geno02

#Step2-1 filter call ratet by 748 TWBs convert plink format
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2  \
--vcf /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB.vcf.gz  \
--snps-only \
--recover-var-ids /staging/biology/u00phl00/ref/GATK/Hg38/dbsnp157.vcf.gz force partial \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--threads 56
#Step2-2 Output a list of SNPs with call rate > 0.98 in 748 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB  \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02
#Step3-2 Filter to SNPs in the previous step, output a list of samples with call rate > 0.98 in 748 TWB
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02.snplist \
--missing \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02

awk 'NR>1{if($6<0.02){print $1,$2}}' \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02.imiss  > \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02.indlist

#Step4-2 Filter to samples in the previous step, output a list of SNPs with call rate > 0.98 in 748 TWB
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB  \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02.indlist \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02_geno02

#Step5-2. Keep samples and SNPs passing previous filters, calculate SNP-level missing rate in 748 TWB
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02.indlist \
--missing \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02_geno02
# Find common SNPs across all batches
awk 'NR>1{arr[$2]++; if (FILENAME != prevfile) {c++; prevfile = FILENAME}} END {for (i in arr) {if (arr[i] == c) {print i}}}' \
/staging/biology/elephant123/269_bc_and_748_TWB/*_in_geno02_mind02_geno02.lmiss  > \
/staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_269_BC_and_748_TWB_in_geno02_mind02_geno02.lmiss.common.snplist

#Step6-1 Remove SNPs with a significant difference in missing rates between the TWB and BC groups by  270 BC
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_269_BC_and_748_TWB_in_geno02_mind02_geno02.lmiss.common.snplist  \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02.indlist \
--exclude /staging/biology/elephant123/269_bc_and_748_TWB/TWB_and_BC_overall_missRateDiff_0.001.snplist \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_in_geno02_mind02_geno02

#Step6-2. Keep samples and SNPs passing previous filters, calculate SNP-level missing rate in 748 TWB
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_269_BC_and_748_TWB_in_geno02_mind02_geno02.lmiss.common.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02.indlist \
--exclude /staging/biology/elephant123/269_bc_and_748_TWB/TWB_and_BC_overall_missRateDiff_0.001.snplist \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB_in_geno02_mind02_geno02

#Step7 Remove merge dataset of  snp
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--keep-allele-order \
--bmerge /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_266_BC  \
--threads 56

#Step7-1 Remove 269 BC and 748 TWB batch both variant
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC \
--exclude /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_266_BC-merge.missnp \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC-tmp \
--threads 56

#Step7-2 Remove 269 BC and 748 TWB batch both variant
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB \
--exclude /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_266_BC-merge.missnp \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB-tmp \
--threads 56

/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC-tmp \
--keep-allele-order \
--bmerge /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_748_TWB-tmp \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB \
--threads 56

# Step8. Remove duplicate SNPs use plink2
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2 \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB \
--rm-dup exclude-all \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB_remove_repeat_id \
--set-all-var-ids @:#
#Step9 Remove un-mapped (--not-chr), and monomorhpic (mac>0) SNPs
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile  /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB_remove_repeat_id \
--not-chr 0 \
--mac 1 \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB_qc_finlish
#Step10 remove extreme count  in hwe <1e-10
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/remove_batch_by_270_BC_and_748_TWB_qc_finlish \
--geno 0.02 \
--hwe 1e-10 \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish

#Step 11  PCA on study sample
#Step 11-1 Find strand ambiguous SNPs
python2 find_atgc_snps.py \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.bim >  \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.atgc.snplist

#Step 11-2 Write a list of non-strand ambiguous SNPs to keep
awk 'NR==FNR{a[$1];next} !($2 in a) {print $2}' \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.atgc.snplist \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.bim >  \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.non-atgc.snplist

#Step 11-3 Perform LD pruning
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--autosome \
--geno 0.02 \
--maf 0.05 \
--snps-only just-acgt \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.non-atgc.snplist \
--exclude range long_range_LD_intervals.txt \
--indep-pairwise 200 100 0.1 \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ldpr
#Step 11-4 Run pca
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink  \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ldpr.prune.in \
--pca 20 header tabs \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish.pca

#Step12 count Het in our data
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ldpr.prune.in \
--het \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ldpr

#Step 13 Estimate IBD
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ldpr.prune.in \
--genome \
--min 0.125 \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish-ibd-min0.125

#Step 14 get samples with IBD greater than 0.125 or het outside of 6 SD
cat  /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_266_BC_het_outlier_6sd.indlist \
/staging/biology/elephant123/269_bc_and_748_TWB/IBD_TWB_merge_269_BC_ibd_pihat02.indlist | sort | uniq > \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_check_het_ibd.remove.indlist

/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile  /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_qc_finlish \
--remove /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_check_het_ibd.remove.indlist \
--pheno /staging/biology/u00phl00/Research/Original_Data/phenotypes.txt \
--assoc fisher --make-bed  \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_pass_filtered

/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_pass_filtered \
--recode vcf-iid bgz \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_pass_filtered

/work/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.18/bin/bcftools index -t -f \
   /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_pass_filtered.vcf.gz \
--threads 56

#Step 15 remove having BRCA 1/2 variant of BC patiant and count F test
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_pass_filtered \
--remove /staging/biology/elephant123/269_bc_and_748_TWB/BCRA_patient.list \
--pheno /staging/biology/u00phl00/Research/Original_Data/phenotypes.txt \
--assoc fisher --make-bed  \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered
