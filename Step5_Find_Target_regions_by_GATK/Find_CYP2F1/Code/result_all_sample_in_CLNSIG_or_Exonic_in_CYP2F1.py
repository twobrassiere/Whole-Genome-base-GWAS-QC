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
            if k.find("_hard_filter_in_CYP2F1.hg38_multianno.txt") > 0:
                file_names.append(k)
                file_fullpath.append(os.path.join(dirPath, k))

    return dir_path, dir_names, file_names, file_fullpath, os_path

def make_dirs(file_names):
    dir_name_set = set()

    for i in file_names:
        if "_hard_filter_in_CYP2F1.hg38_multianno.txt" in i:
            sample_name = i.replace("_hard_filter_in_CYP2F1.hg38_multianno.txt", "")
            dir_name_set.add(sample_name)

    dir_name = list(dir_name_set)

    print("2.dir_name:")
    print(dir_name)

    return dir_name

# Get the file information
open_path = '/staging/biology/elephant123/748_TWB_VCF_in_CYP2F1/CYP2F1_annoation_data'  # Replace with your actual directory path
result_all_sample_in_CYP2F1=open('/staging/biology/elephant123/748_TWB_VCF_in_PRAMEF2/CYP2F1_annoation_data/result_all_sample_in_hard_filter_CYP2F1.txt','w')

# Check if the directory exists
if not os.path.exists(open_path):
    print(f"Error: Directory '{open_path}' does not exist.")
else:
    dir_path, dir_names, file_names, file_fullpath, os_path = open_all_file_path(open_path)
    sample_names = make_dirs(file_names)
    # Write header only once
    header_written = False

    # Loop through the list of file paths
    for file_path in file_fullpath:
        # Extract sample name from the file path
        sample_name = os.path.basename(file_path).replace("_hard_filter_in_CYP2F1.hg38_multianno.txt", "")

        try:
            # Open the input file for reading
            with open(file_path, 'r') as input_file:
                # Read the header line
                header = input_file.readline().strip().split('\t')
                # Find the index of the GeneDetail.knownGene column
                gene_index = header.index('GeneDetail.knownGene')
                # Create a list to store filtered rows
                filtered_rows = []

                # Loop through the remaining lines in the file
                for line in input_file:
                    # Split the line into columns
                    columns = line.strip().split('\t')
                    filtered_rows.append(line)
                # Add sample name column in header if not written already
                if not header_written:
                    header.insert(0, 'Sample_Name')
                    header.extend(["Otherinfo1", "Otherinfo2", "Otherinfo3", "Otherinfo4",
                    "Otherinfo5", "Otherinfo6", "Otherinfo7", "Otherinfo8", "Otherinfo9", "Otherinfo10", "Otherinfo11", "Otherinfo12"])
                    result_all_sample_in_CYP2F1.write('\t'.join(header) + '\n')
                    header_written = True

                # Loop through the remaining lines in the file
                for line in input_file:
                    # Split the line into columns
                    columns = line.strip().split('\t')
                    # Add sample name column in filter rows
                    filtered_rows.append(sample_name + '\t' + line)

                # Add sample name column in filter rows
                filtered_rows = [sample_name + '\t' + row for row in filtered_rows]
                sort_rows = sorted(filtered_rows, key=lambda x: x.split('\t')[gene_index])
                sort_rows = [row for row in sort_rows]
                sort_rows=''.join(sort_rows)
                # Write the filtered rows to the output file
                result_all_sample_in_CYP2F1.write(sort_rows)

        except Exception as e:
            print(f"Error processing {sample_name}: {e}")

    # Close the output file
    result_all_sample_in_CYP2F1.close()
