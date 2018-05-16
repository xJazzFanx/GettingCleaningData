# GettingCleaningData
title: "README.md"
author: "Paul Morlen"
date: "5/14/2018"
output: html_document
---

Review criteria

    1. The submitted data set is tidy. => Please refer to file SubjActivityAverage.txt
    2. The Github repo contains the required scripts.  => Please refer to run_analysis.R
    3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units,and any other relevant information.  => Please refer to "codebook_SubjActivityAverage.Rmd""
    4. The README that explains the analysis files is clear and understandable.  => This is the file you are reading.
    5. The work submitted for this project is the work of Paul Morlen.
    
    
Getting and Cleaning Data Course Project

    The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.  The goal is to prepare tidy data that can be used for later analysis.

Project Requirements
    1. Merges the training and the test sets to create one data set.  => My assumption is the script begins with the data files downloaded and unzipped for reading into data frames.  
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for     each activity and each subject. => The tidy data set is named:  "SubjActivityAverage.txt"
    
Script Actions
    1. Load necessary libraries
    2. Read into data frames data files of feature information, activity labels, subject, test, and training data files.
    3. Merge all data frames and activity and subject data.
    4. Extract mean and standard deviation measurments.
    5. Clean up variable names.
    6. Create a tidy data set where 1) each variable forms a column, 2) each observation forms a row, and 3) each value must have its own cell.  The tidy data set is the file:  "SubjActivityAverage.txt"
