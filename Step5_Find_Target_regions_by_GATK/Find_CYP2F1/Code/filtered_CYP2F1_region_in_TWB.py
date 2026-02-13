import os
import time
def mark_occurrences(template, placeholders):
    for placeholder, value in placeholders.items():
        template = template.replace(placeholder, value)
    return template

def generate_slurm_script(sample_name, input_dir,output_dir):
    # Define the Slurm job template
    slurm_template = '''#!/bin/sh
#SBATCH -A MST109178
#SBATCH -J filtered_CYP2F1_region_in_{sample_name}
#SBATCH -p ngs7G
#SBATCH -c 1
#SBATCH --mem=7g
#SBATCH -o {input_dir}/{sample_name}_CYP2F1.out.log
#SBATCH -e {input_dir}/{sample_name}_CYP2F1.err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END
ml add miniconda3/24.1.2
conda activate /staging/biology/elephant123/Conda



#a single-sample GVCF convert to vcf
#/work/opt/ohpc/Taiwania3/pkg/biology/GATK/gatk_v4.2.3.0/gatk  \
#--java-options "-Xmx7g" GenotypeGVCFs \
#-R /staging/biology/elephant123/GATK/DRAGEN_hg38/hg38.fa \
#-V {input_dir}/{sample_name}.vcf.gz \
#-O {output_dir}/{sample_name}/{sample_name}.vcf.gz

mkdir  -p {output_dir}/{sample_name}/CYP2F1
#Select the region around the CYP2F1 gene, extending upstream 3KB and downstream 1KB
/work/opt/ohpc/Taiwania3/pkg/biology/GATK/gatk_v4.2.3.0/gatk \
--java-options "-Xmx7g" SelectVariants  \
-R /staging/biology/elephant123/GATK/DRAGEN_hg38/hg38.fa  \
-L  chr19:41111432-41129381 \
-V {input_dir}/{sample_name}.vcf.gz \
-O {output_dir}/{sample_name}/CYP2F1/{sample_name}_in_CYP2F1.vcf.gz

/work/opt/ohpc/Taiwania3/pkg/biology/GATK/gatk_v4.2.3.0/gatk \
--java-options "-Xmx7G -XX:ParallelGCThreads=1" VariantFiltration \
-R /staging/biology/elephant123/GATK/DRAGEN_hg38/hg38.fa \
-V {output_dir}/{sample_name}/CYP2F1/{sample_name}_in_CYP2F1.vcf.gz \
-O {output_dir}/{sample_name}/CYP2F1/{sample_name}_hard_filter_in_CYP2F1.vcf.gz \
--filter-name "QD_filter" \
--filter-expression "QD < 2.0" \
--filter-name "FS_filter" \
--filter-expression "FS > 60.0" \
--filter-name "MQ_filter" \
--filter-expression "MQ < 40.0" \
--filter-name "SOR_filter" \
--filter-expression "SOR > 3.0" \
--filter-name "MQRankSum_filter" \
--filter-expression "MQRankSum < -12.5" \
--filter-name "ReadPosRankSum_filter" \
--filter-expression "ReadPosRankSum < -8.0"



#### VCF annoation by annovar
perl /staging/biology/u00phl00/App/annovar/table_annovar.pl \
-buildver hg38 \
-out  {output_dir}/{sample_name}/CYP2F1/{sample_name}_hard_filter_in_CYP2F1 \
-vcfinput  {output_dir}/{sample_name}/CYP2F1/{sample_name}_hard_filter_in_CYP2F1.vcf.gz  \
/staging/biology/u00phl00/App/annovar/humandb/ \
-remove -protocol refGene,knownGene,clinvar_20221231,cytoBand,esp6500siv2_all,1000g2015aug_all,exac03,avsnp150,dbnsfp35c -operation g,g,f,r,f,f,f,f,f \
-nastring . -otherinfo




'''

    # Replace placeholders in the template with actual values
    replacements = {
        '{sample_name}': sample_name,
        '{input_dir}': input_dir,
        '{output_dir}': output_dir
    }
    marked_slurm_script = mark_occurrences(slurm_template, replacements)

    # Save the customized Slurm script
    script_path = os.path.join(input_dir, "{}_CYP2F1_slurm_script.sh".format(sample_name))
    with open(script_path, 'w') as script_file:
        script_file.write(marked_slurm_script)

    return script_path

def submit_slurm_job(script_path):
    os.system("sbatch {}".format(script_path))

# Example usage
input_dir = "/staging/biology/elephant123/270_BC_annonation"
output_dir= "/staging/biology/elephant123/748_TWB_VCF_in_PRAMEF2"
# Assuming sequence files are in the format sample_name_R1.fastq.gz and sample_name_2.fastq.gz
def open_all_file_path(open_path): #
    dir_path = []
    dir_names = []
    file_names = []

    file_fullpath = []
    os_path = []

    for dirPath, dirNames, fileNames in os.walk(open_path):

        dir_path.append(dirPath)

        for j in dirNames:
            dir_names.append(j)
        for k in fileNames:
            if k.find(".vcf.gz")>0:
                file_names.append(k)
            file_fullpath.append(os.path.join(dirPath,k))

    return dir_path,dir_names,file_names,file_fullpath,os_path

dir_site = os.getcwd() #
dir_path, dir_names, file_names,file_fullpath,os_path = open_all_file_path(dir_site)


print("1.file_names:")
print(file_names)


def make_dirs(file_names):
    dir_name_set = set()

    for i in file_names:
        if ".vcf.gz" in i:
            j = i.split(".vcf.gz")[0]
            dir_name_set.add(j)

    dir_name = list(dir_name_set)

    print("2.dir_name:")
    print(dir_name)

    return dir_name

dir_name = make_dirs(file_names)
sample_names= dir_name



for sample_name in sample_names:
    generated_script_path = generate_slurm_script(sample_name, input_dir,output_dir)
    time.sleep(1)
    submit_slurm_job(generated_script_path)
