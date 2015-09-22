Codebook - Getting and Cleaning Data Course Project
===

The script outputs a single file, step5DataSet.txt. The columns in this file are:

1. SubjectID
	Integer representing the subject taking the test. Range 1-30.
2. 	ActivityName
	String representing the activity being performed during the measurements. Factor variable of "LAYING," "SITTING," "STANDING," "WALKING," "WALKING_DOWNSTAIRS," or "WALKING_UPSTAIRS."
3. 	tBodyAccMag-mean()
	An average of all tBodyAccMag-mean() measurements for this subject performing this activity.
4. 	tGravityAccMag-mean()
	An average of all tGravityAccMag-mean() measurements for this subject performing this activity.
5.	tBodyAccJerkMag-mean()
	An average of all tBodyAccJerkMag-mean() measurements for this subject performing this activity.
6.	tBodyGyroMag-mean()
	An average of all tBodyGyroMag-mean() measurements for this subject performing this activity.
7.	tBodyGyroJerkMag-mean()
	An average of all tBodyGyroJerkMag-mean() measurements for this subject performing this activity.
8.	fBodyAccMag-mean()
	An average of all fBodyAccMag-mean() measurements for this subject performing this activity.
9.	fBodyBodyAccJerkMag-mean()
	An average of all fBodyBodyAccJerkMag-mean() measurements for this subject performing this activity.
10.	fBodyBodyGyroMag-mean()
	An average of all fBodyBodyGyroMag-mean() measurements for this subject performing this activity.
11.	fBodyBodyGyroJerkMag-mean()
	An average of all fBodyBodyGyroJerkMag-mean() measurements for this subject performing this activity.
12.	tBodyAccMag-std()
	An average of all tBodyAccMag-std() measurements for this subject performing this activity.
13.	tGravityAccMag-std()
	An average of all tGravityAccMag-std() measurements for this subject performing this activity.
14.	tBodyAccJerkMag-std()
	An average of all tBodyAccJerkMag-std() measurements for this subject performing this activity.
15.	tBodyGyroMag-std()
	An average of all tBodyGyroMag-std() measurements for this subject performing this activity.
16.	tBodyGyroJerkMag-std()
	An average of all tBodyGyroJerkMag-std() measurements for this subject performing this activity.
17.	fBodyAccMag-std()
	An average of all fBodyAccMag-std() measurements for this subject performing this activity.
18.	fBodyBodyAccJerkMag-std()
	An average of all fBodyBodyAccJerkMag-std() measurements for this subject performing this activity.
19.	fBodyBodyGyroMag-std()
	An average of all fBodyBodyGyroMag-std() measurements for this subject performing this activity.
20.	fBodyBodyGyroJerkMag-std()
	An average of all fBodyBodyGyroJerkMag-std() measurements for this subject performing this activity.
    
Variables, Data, and Transformations 
---
The course requirements include "...a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data." These are documented here:

###Variables
The script uses the following variables:
* xtest, ytest, subjecttest
	The three 'test' data sets read from the original source data.
* xtrain, ytrain, subjecttrain
	The three 'train' data sets read from the original source data
* xmerged, ymerged, subjectmerged
	Merged dataframes of the x, y, and subject data. These are created by doing an rbind() of the test and train data sets.
* features
	The features data set as read from the original source data
* mergedData
	A data frame that contains all of the read data. The features are mapped to column headers of the xmerged variable. Column names for ymerged and subjectmerged are added as hardcoded strings. Then the three merged dataframes are stitched together with cbind()
* activitylabels
	The names of each activity as read from activity_labels.txt. This is used to map an activity number to an activity name in the mergedData variable with an inner join, adding a column "ActivityName" to the mergedData dataframe
* columnsToKeep
	A vector of column indices from mergedData to retain for futher processing. This includes columns "ActivityName," "SubjectID," and any column name ending in "-mean()" or "-std()"
* step4DataSet
	A data frame that contains only the columns of mergedData that are in the columnsToKeep vector
* step5DataSet
	A data frame that creates a mean of each measurement column of the step4DataSet for each subjectID/Activity pair. Created withddply() and the numcolwise(mean) functions.
    
###Data
All of the data in the project is sourced from the "Human Activity Recognition Using Smartphones" data set at the UCI Machine Learning Repository at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

###Transformations
Data transformations include rbind() and cbind() to merge all of the testing and training data into a single merged dataframe, mergedData.

Column names of mergedDataare changed using the colnames() function with labels from the features.txt file and hardcoded strings for "SubjectID" and "ActivityLabel."

Activity names are appended to the mergedData with inner_join() using "ActivityLabel" as the key.

The final dataset is created with the ddply() function using  numcolwise(mean) as the summary function to apply.

