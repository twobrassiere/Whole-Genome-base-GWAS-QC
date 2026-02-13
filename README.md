# Whole-Genome-base-GWAS-QC
The GWAS QC had 5 parts:

Step1, Joint variant calling was performed separately for each cohort—comprising 748 female Taiwan Biobank participants and 269 female breast cancer patients  —using the DRAGEN Iterative gVCF Genotyper (IGG).

Step2, We utilized high-confidence regions from the HG002 reference sample and applied bcftools to ensure a missingness rate of less than 2% across each cohort.
Merged the VCF files from both cohorts without batch effect correction to perform subsequent Quality Control (QC) and ancestry analysis
Code for Steps 1 and 2 provided by [Jacob Shu-Jui Hsu](https://www.mc.ntu.edu.tw/medgenpro/Vcard.action?q_type=-1&q_itemCode=1100&l=en_US).

Step3, [GWAS Quality Control](https://github.com/Annefeng/PBK-QC-pipeline) & Population Analysis (Reviewed by [Anna Feng](https://fenglab520.github.io/author/%E9%A6%AE%E5%AC%BF%E8%87%BB-yen-chen-anne-feng/))

   1. Preliminary PCA:
      Performed PCA on the merged cohort data without batch effect removal to visualize the initial data structure.
         
   2. Ancestry Analysis:
      Merged the cohort VCFs with the 1000 Genomes Project (1000G) reference panel to perform global ancestry analysis.
         
   3. Refined PCA & Filtering: After batch effect removal, conducted a secondary PCA and applied standard QC filters:
      Excluded samples with high Heterozygosity (Het) or Identity-by-Descent (IBD) relatedness, and removed patients carrying known BRCA2 mutations.

     
