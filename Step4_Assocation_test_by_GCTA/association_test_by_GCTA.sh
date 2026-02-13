#!/usr/bin/sh
#SBATCH -A MST109178
#SBATCH -J merge_two_dataset_and_PCA_anaylzise_by_Plink
#SBATCH -p ngs3T_56
#SBATCH -c 56
#SBATCH --mem=3000g
#SBATCH -o /staging/biology/elephant123/PCA_out.log
#SBATCH -e /staging/biology/elephant123/PCA_err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END




# create basic GRM in BC without BRCA mutant and 748 TWB
/staging/biology/u00phl00/Source_code/gcta-1.94.3-linux-kernel-3-x86_64/gcta64 \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered   \
--remove /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_check_het_ibd.remove.indlist \
--maf 0.01 \
--autosome \
--make-grm \
--out  /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered   \
--thread-num 56

# MLMA leaving-one-chromosome-out (LOCO) analysis in BC without BRCA mutant and 748 TWB
/staging/biology/u00phl00/Source_code/gcta-1.94.3-linux-kernel-3-x86_64/gcta64 \
--mlma-loco \
--maf 0.01 \
--bfile /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered  \
--remove /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_269_BC_check_het_ibd.remove.indlist \
--pheno /staging/biology/u00phl00/Research/Original_Data/phenotypes.txt \
--grm /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered    \
--out /staging/biology/elephant123/269_bc_and_748_TWB/TWB_merge_BC_without_BCRA_pass_filtered_QC_LOCO  \
--thread-num 56
