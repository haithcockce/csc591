#!/usr/bin/python3
import numpy
import csv
import ipdb

def main():

    data = []
    labels = set()
    mappings = []
    classifications = []

    # Let's start building the mappings. Need either a set or empty list
    # for each of the columns, set for non-int/float and empty list for otherwise
    csvfile = open('../data/adult.data')
    reader = csv.reader(csvfile)
    row = next(reader)
    for i in range(len(row) - 1):  # ignore the last column (label)
        if row[i].isdigit():
            mappings.append([])
        else: 
            try:
                float(row[i])        # isdecimal() always returns false, but 
                mappings.append([])  # this works so whatever
            except:
                mappings.append(set())

    # Read csv file in and account for strings
    # This assumes data file is only data and has no headers, footers, 
    # etc. Also assumes the classification is appended to the end of each
    # record. 
    with open('../data/adult.data') as f:
        reader = csv.reader(f)
        for row in reader:
            if len(row) == 0:  # Some files may have empty rows
                continue       # so skip them
            for i in range(len(row) - 1):  # -1 because we'll grab classes later
                if type(mappings[i]) == set:
                    mappings[i].add(row[i])  # add the unique value 
            labels.add(row[-1])  # grab the label now
            del row[-1]          # Remove classification 
            data.append(row)

    
    # Convert everything to lists so we have indeces
    for i in range(len(mappings)):
        mappings[i] = list(mappings[i])
    labels = list(labels)

    # Clean data, so convert strings to 
    for i in range(len(data)):
        for j in range(len(data[i])):

            # convert to int if int
            if data[i][j].isdigit():
                data[i][j] = int(data[i][j])
            else:
                # convert to float if float
                try:
                    data[i][j] = float(data[i][j])
                # use index as int replacement
                except:
                    data[i][j] = mappings[j].index(data[i][j])



if __name__ == '__main__':
    main()
