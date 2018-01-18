# Getting_and_Cleaning_Data_Project
Week 4 Project in Coursera Getting and Cleaning Data

# run_analysis.R script
The script does the following

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# How the script works

1. The first part downloads the data set from the source.
2. The file is unzip to a directory, in my assignment, it's in ./data found in my computer.
3. Activity labels and features are loaded.
4. As instructed, there is a code that extracts only the data on mean and standard deviation.
5. The data sets from the source, properly labelled, are loaded and merged.
6. "activities" and "subjects" are turned into factors.
7. A second tidy data set is created to "tidy.txt".
