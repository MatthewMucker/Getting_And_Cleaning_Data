Getting and Cleaning Data Course Project
===

This repo includes a single R script, run_analysis.R, that consumes data from the UCI Machine Learning Repository's "Human Activity Recognition Using Smartphones Data Set."

The script merges the testing and training data, adds descriptive labels to each column, adds the activity name as an additional column, then extracts only columns with standard deviation or mean values. After the extraction, it outputs a tidy data set with one row per subject/activity combination that includes the averages of each column for each subject/activity.

There is a single script that does all of the work. The script executes lineraly, with no loops or conditional branches.