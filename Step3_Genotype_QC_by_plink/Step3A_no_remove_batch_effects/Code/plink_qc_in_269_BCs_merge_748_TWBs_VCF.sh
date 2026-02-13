#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J plink_qc_test
#SBATCH -p ngs3T_56
#SBATCH -c 56
#SBATCH --mem=3000g
#SBATCH -o /staging/biology/elephant123/PCA_out.log
#SBATCH -e /staging/biology/elephant123/PCA_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END

#Step1 filter call ratet by 270 BC merge 748 TWB convert plink format
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2  \
--vcf /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB.vcf.gz  \
--snps-only \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB \
--threads 56

#Step2 Output a list of SNPs with call rate > 0.98
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB  \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02

# Step3 Filter to SNPs in the previous step, output a list of samples with call rate > 0.98
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02.snplist \
--missing \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02
awk 'NR>1{if($6<0.02){print $1,$2}}' \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02.imiss > \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.indlist

# Step4 Filter to samples in the previous step, output a list of SNPs with call rate > 0.98
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.indlist \
--geno 0.02 \
--write-snplist \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02

# Step5 Keep samples and SNPs passing previous filters, calculate SNP-level missing rate
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/filter_call_ratet_by_270_BC_and_748_TWB \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02.snplist \
--keep /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.indlist \
--missing \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02

# Step6. Remove duplicate SNPs use plink2
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK2/PLINK_v2.00a3LM_AVX2_16Aug/plink2 \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02 \
--rm-dup exclude-all \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02_remove_repeat_id \
--set-all-var-ids @:#
#Step7 Remove un-mapped (--not-chr), and monomorhpic (mac>0) SNPs
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile  /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02_remove_repeat_id \
--not-chr 0 \
--mac 1 \
--make-bed \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02_qc_finlish
#Step 8 remove extreme count  in hwe <1e-6
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02_qc_finlish \
--geno 0.02 \
--hwe midp  1e-6   \
--make-bed --out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02
#Step 8  PCA on study sample
#Step 8-1 Find strand ambiguous SNPs
python2 find_atgc_snps.py \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.bim >  \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.atgc.snplist

#Step 8-2 Write a list of non-strand ambiguous SNPs to keep
awk 'NR==FNR{a[$1];next} !($2 in a) {print $2}' \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.atgc.snplist \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.bim >  \
/staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.non-atgc.snplist

#Step 8-3 Perform LD pruning
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02 \
--autosome \
--geno 0.02 \
--maf 0.05 \
--snps-only just-acgt \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.non-atgc.snplist \
--exclude range long_range_LD_intervals.txt \
--indep-pairwise 200 100 0.1 \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02-ldpr
#Step 8-4 Run pca
/work/opt/ohpc/Taiwania3/pkg/biology/PLINK/PLINK_v1.90/plink  \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02 \
--extract /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02-ldpr.prune.in \
--pca 20 header tabs \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_in_geno02_mind02.pca
