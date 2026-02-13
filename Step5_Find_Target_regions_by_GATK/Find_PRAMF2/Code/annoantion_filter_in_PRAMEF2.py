import os

def open_all_file_path(open_path):
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
            if k.find("_hard_filter_in_PRAMEF2.hg38_multianno.txt") > 0:
                file_names.append(k)
                file_fullpath.append(os.path.join(dirPath, k))

    return dir_path, dir_names, file_names, file_fullpath, os_path

def make_dirs(file_names):
    dir_name_set = set()

    for i in file_names:
        if "_hard_filter_in_PRAMEF2.hg38_multianno.txt" in i:
            sample_name = i.replace("_hard_filter_in_PRAMEF2.hg38_multianno.txt", "")
            dir_name_set.add(sample_name)

    dir_name = list(dir_name_set)

    print("2.dir_name:")
    print(dir_name)

    return dir_name


# Get the file information
open_path = '/staging/biology/elephant123/748_TWB_VCF_in_PRAMEF2/PRAMEF2_annoation_data'  #Dictionary of tmporarily put all PRAMEF2 hg38_multianno.txt file

# Check if the directory exists
if not os.path.exists(open_path):
    print(f"Error: Directory '{open_path}' does not exist.")
else:
    dir_path, dir_names, file_names, file_fullpath, os_path = open_all_file_path(open_path)
    sample_names = make_dirs(file_names)

    # Loop through the list of file paths
    for file_path in file_fullpath:
        # Extract sample name from the file path
        sample_name = os.path.basename(file_path).replace("_hard_filter_in_PRAMEF2.hg38_multianno.txt", "")

        try:
            header_written = False  # Initialize header_written variable
            # Open the input file for reading
            with open(file_path, 'r') as input_file:

                # Read the header line
                header = input_file.readline().strip().split('\t')
                if not header_written:
                    header.extend(["Otherinfo1", "Otherinfo2", "Otherinfo3", "Otherinfo4",
                    "Otherinfo5", "Otherinfo6", "Otherinfo7", "Otherinfo8", "Otherinfo9", "Otherinfo10", "Otherinfo11", "Otherinfo12"])
                    header_written = True
                # Find the index of the CLNSIG ExonicFunc_refGene and Func.refGene columncolumn


                Func_index=header.index('Func.refGene')
                #Find the index of the gene name (Gene.refGene)
                gene_name_index=header.index('Gene.refGene')
                #Filter the index of 1000g2015aug_all or ExAC_ALL or esp6500siv2_all column less than 0.01
                g2015aug_all_index=header.index('1000g2015aug_all')
                ExAC_ALL_index=header.index('ExAC_ALL')
                esp6500siv2_all_index=header.index('esp6500siv2_all')
                # Create a list to store filtered rows
                filtered_rows = []

                # Loop through the remaining lines in the file
                for line in input_file:
                    # Split the line into columns
                    columns = line.strip().split('\t')
                    g2015aug_all = 0.0 if columns[g2015aug_all_index] == '.' else columns[g2015aug_all_index]
                    ExAC_ALL = 0.0 if columns[ExAC_ALL_index] == '.' else columns[ExAC_ALL_index]
                    esp6500siv2_all = 0.0 if columns[esp6500siv2_all_index] == '.' else columns[esp6500siv2_all_index]
                        # Convert the columns to float and check the condition
                    if float(g2015aug_all) < 0.01 and float(ExAC_ALL) < 0.01 and float(esp6500siv2_all) < 0.01:
                            # Check if AF > 0.05 in Otherinfo12 column
                            otherinfo12_value = columns[header.index('Otherinfo12')].split(":")[2].split(",")[0]
                            if (float(otherinfo12_value) > 0.05) :
                                 # Add the row to the filtered list in PRAMEF2 gene_name_index
                                filtered_rows.append(line)

            # Open a new file for writing the filtered results
            output_file_path = f'{sample_name}_hard_filter_in_PRAMEF2.hg38_multianno.txt'
            with open(output_file_path, 'w') as output_file:
                # Write the header to the output file
                output_file.write('\t'.join(header) + '\n')

                # Write the filtered rows to the output file
                output_file.writelines(filtered_rows)

            print(f"Filtering complete for {sample_name}. Filtered results saved in {output_file_path}.")

        except Exception as e:
            print(f"Error processing {sample_name}: {e}")
