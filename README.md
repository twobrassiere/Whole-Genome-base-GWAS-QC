# Whole-Genome-base-GWAS-QC
Our GWAS QC workflow is divided into five parts. Included below are the [pipeline diagrams and QC](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/blob/main/Workflow_plot/GWAS%20workflow%20in%20SNP%20base.pdf) that define the filtering thresholds used for both [SNP-level and sample-level quality control](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/blob/main/Workflow_plot/SNP%20number%20in%20GWAS%20workflow.pdf).

[Step1](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step1_Joint_calling_by_IGG), Joint variant calling was performed separately for each cohort—comprising 748 female Taiwan Biobank participants and 269 female breast cancer patients  —using the DRAGEN Iterative gVCF Genotyper (IGG).

[Step2](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step2_Variant_QC_by_bcftools) We utilized high-confidence regions from the HG002 reference sample and applied bcftools to ensure a missingness rate of less than 2% across each cohort.
[Merged the VCF files](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/blob/main/Step2_Variant_QC_by_bcftools/Variant_QC_in_269_BC_merge_748_TWBs.sh) from both cohorts without batch effect correction to perform subsequent Quality Control (QC) and ancestry analysis
Code for Steps 1 and 2 provided by [Jacob Shu-Jui Hsu](https://www.mc.ntu.edu.tw/medgenpro/Vcard.action?q_type=-1&q_itemCode=1100&l=en_US)(Co-author).

Step3, [GWAS Quality Control](https://github.com/Annefeng/PBK-QC-pipeline) & Population Analysis (Reviewed by [Anna Feng](https://fenglab520.github.io/author/%E9%A6%AE%E5%AC%BF%E8%87%BB-yen-chen-anne-feng/))

   3A. [Preliminary PCA](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step3_Genotype_QC_by_plink/Step3A_no_remove_batch_effects):
      Performed PCA on the merged cohort data without batch effect removal to visualize the initial data structure.
                
   3B. [Refined PCA & Filtering: After batch effect removal, conducted a secondary PCA and applied standard QC filters](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step3_Genotype_QC_by_plink/Step3B_remove_batch_effect):
      Excluded samples with high Heterozygosity (Het) or Identity-by-Descent (IBD) relatedness, and removed patients carrying known BRCA2 mutations.

   3C. [Ancestry Analysis](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step3_Genotype_QC_by_plink/Step3C_ancestry%20analysis):
      Merged the cohort VCFs with the 1000 Genomes Project (1000G) reference panel to perform global ancestry analysis.

[Step4](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step4_Assocation_test_by_GCTA) We utilized the GCTA LOCO model for association analysis and regional signaling visualization through [LocusZoom](https://my.locuszoom.org/gwas/135960/) and [Python code](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step4_Assocation_test_by_GCTA/GWAS_data_by_python/Plot_by_GCTA_LOCO). For further validation, we performed an [F-test](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step4_Assocation_test_by_GCTA/GWAS_data_by_python/Plot_by_F_test_by_plink) using the same set of QC-passed variants and implemented interactive data visualization using Python code.

[Step5](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/tree/main/Step5_Find_Target_regions_by_GATK) Identified two novel exonic susceptibility genes:[PRAMF2](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/blob/main/Step5_Find_Target_regions_by_GATK/Find_PRAMF2/result_all_sample_in_hard_filter_PRAMEF2.xlsx) and [CYP2F1](https://github.com/twobrassiere/Whole-Genome-base-GWAS-QC/blob/main/Step5_Find_Target_regions_by_GATK/Find_CYP2F1/result_all_sample_in_CYP2F1.xlsx). The pipeline uses GATK to subset the genomic regions (including upstream and downstream sequences), followed by standard hard filtering to isolate high-confidence variant signatures.

Figures for Steps 3–4 were produced in [Google Colab](https://colab.research.google.com/drive/1yGTzawkH-X8bxJX4IpxB7sDYm8BoI1bb), utilizing data hosted on and retrieved from [Google Drive folders](https://drive.google.com/drive/folders/1YzylhCcmy61k2Pt1fxY1ZDDKl7EuQTb5?usp=sharing).


Finally, we observed a 2% variant discrepancy between different DRAGEN versions when processing the same 11 Taiwan Biobank (TWB) samples. All analyses were conducted in [Google Colab](https://colab.research.google.com/drive/1Vn0S8-1hmuHVk5D7MNC1zdUX26lpDaQ3?usp=drive_link), with the required datasets retrieved from shared [Google Drive folders]](https://drive.google.com/drive/folders/12bvqSECCmdcWjFUH70MMl0NR2d6HrUTV?usp=sharing).

