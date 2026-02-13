import os
import time

def mark_occurrences(template, placeholders):
    for placeholder, value in placeholders.items():
        template = template.replace(placeholder, value)
    return template

def submit_slurm_job(script_path):
    os.system("sbatch {}".format(script_path))
def generate_slurm_script( chrom):
    # Define the Slurm job template
    slurm_template = '''#!/bin/sh
#SBATCH -A MST109178
#SBATCH -J phase_1000G_by_dragen_ver4.2.7
#SBATCH -p ngs1T_18
#SBATCH -c 18
#SBATCH --mem=1000g
#SBATCH -o /staging/biology/elephant123/1000G_dragen/chr{chrom}.out.log
#SBATCH -e /staging/biology/elephant123/1000G_dragen/chr{chrom}.err.log
#SBATCH --mail-user=elephantliu0613@gmail.com
#SBATCH --mail-type=BEGIN,END

ml load biology
ml load BCFtools/1.18


#Step 1  phase in 1000G  by shapeit ver 4.2.2
/work/opt/ohpc/Taiwania3/pkg/biology/SHAPEIT/SHAPEIT_v4.2.2/bin/shapeit4.2 \
--input /staging/biology/elephant123/1000G_dragen/3202_samples_cohort_gg_chr{chrom}.vcf.gz \
--map /staging/biology/elephant123/gMAP/chr{chrom}.b38.gmap \
--region chr{chrom} \
--output /staging/biology/elephant123/1000G_dragen/Phased_3202_samples_cohort_gg_chr{chrom}.vcf.gz \
--thread 18
bcftools index -t -f \
   /staging/biology/elephant123/1000G_dragen/Phased_3202_samples_cohort_gg_chr{chrom}.vcf.gz   \
   --threads 18


'''


    # Replace placeholders in the template with actual values
    replacements = {
        '{chrom}': str(chrom)  # Convert chrom to string here
    }
    marked_slurm_script = mark_occurrences(slurm_template, replacements)

    # Save the customized Slurm script with chromosome in the name
    script_path = os.path.join("/staging/biology/elephant123/1000G_dragen/","chr{}_slurm_script.sh".format(chrom))
    with open(script_path, 'w') as script_file:
        script_file.write(marked_slurm_script)

    return script_path

# Example usage
chromosomes = range(7,11)


# Generate Slurm scripts for each chromosome
for chrom in chromosomes:
    generated_script_path = generate_slurm_script(chrom)
    time.sleep(3)  # Optional delay
    submit_slurm_job(generated_script_path)
