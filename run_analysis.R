#load the dplyr library. Used for rename and join functions
library(dplyr)

#load the plyr library for the ddply function
library(plyr)

#====================================
# ASSIGNMENT STEP 1
#     Merge testing and training sets
#====================================

#Set the working directory to the location of the data
setwd('c:/users/mm030p/downloads/RData')

#read the test data
xtest <- read.table('./test/x_test.txt')
ytest <- read.table('./test/y_test.txt')
subjecttest <- read.table('./test/subject_test.txt')

#read the training data
xtrain <- read.table('./train/x_train.txt')
ytrain <- read.table('./train/y_train.txt')
subjecttrain <- read.table('./train/subject_train.txt')


#merge the training and test data together
xmerged <- rbind(xtest, xtrain)
ymerged <- rbind(ytest, ytrain)
subjectmerged <- rbind(subjecttest, subjecttrain)

#we no longer need the original data tables.
#dump them from the R environment to free
#up memory. You know. Just in case.
rm(xtest)
rm(xtrain)
rm(ytest)
rm(ytrain)
rm(subjecttest)
rm(subjecttrain)

#====================================
# ASSIGNMENT STEP 4
#     Label the data set with
#     descriptive variable names
#====================================

#read the feature (variable) names
features <- read.table('features.txt')

#rename the columns in the merged data
#using the features table
colnames(xmerged) <- features[,2]
colnames(ymerged) <-c('ActivityLabel')
colnames(subjectmerged) <- c('SubjectID')

#We don't need the features table any more.
rm(features)

#Create the merged data set
mergedData <- cbind(subjectmerged, xmerged, ymerged)

#we no longer need the unmerged tables
rm(xmerged)
rm(ymerged)
rm(subjectmerged)


#====================================
# ASSIGNMENT STEP 3
#     Use descriptive activity names
#     to name the activities in the 
#     data set
#====================================

#read the activity labels
activitylabels <- read.table('activity_labels.txt')
#rename the columns for readability in the script
activitylabels <- dplyr::rename(activitylabels, ActivityLabel = V1,  ActivityName = V2)

#add the activity name column to the data set
#by joining the merged data with the activity
#labels.
mergedData <- inner_join(mergedData, activitylabels, by.x='ActivityLabel', by.y='ActivityLabel')

#We no longer need the activity labels table.
rm(activitylabels)



#====================================
#At this point, we have a tidy data set! I have one 
#table, with column and row labels. Now I can get to work
#on processing it.
#====================================



#====================================
# ASSIGNMENT STEP 2
#     Extract only measurements on mean
#     and Standard Deviation on each
#     measurement
#====================================

#Build a  vector that tells us which
#columns are mean or s.d. measurements, 
#by looking for '-mean()' or '-std()' 
#at end of line; and add the subject ID
#and activity label columns as well
columnsToKeep <- grep('-mean\\(\\)$', names(mergedData))
columnsToKeep <- c(columnsToKeep, grep('-std\\(\\)$', names(mergedData)))
columnsToKeep <- c(columnsToKeep, grep('ActivityName', names(mergedData)))
columnsToKeep <- c(columnsToKeep, grep('SubjectID', names(mergedData)))

#Create a data frame with only the desired columns
step4DataSet <- mergedData[,columnsToKeep]

#Discard data we no longer need
rm(columnsToKeep)
rm(mergedData)

#====================================
# ASSIGNMENT STEP 5
#   Create a tidy data set with the
#   average of each variable for each
#   activity and subject.
#
# This is the data set I turn in for
# assessment.
#====================================
step5DataSet <- ddply(step4DataSet, c('SubjectID', 'ActivityName'), numcolwise(mean))


#Save the data in the format required by the
#project submission
write.table(step5DataSet, file="Step5Data.txt", row.name=FALSE)
