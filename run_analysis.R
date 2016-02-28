#
# Getting and Cleaning Data Course Project
# 
# Script: run_analysis.R
# Project description:
# You should create one R script called run_analysis.R that does the following. 
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average
#     of each variable for each activity and each subject.


#Load plyr packages

library(plyr)

#Set working Directory
wd <- "C:/Users/Administrator/Desktop/Coursera_Data_Cleaning"
setwd(wd)

#Get the data
#Download the file and put the file in the data folder

if(!file.exists("./Project")){dir.create("./Project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Project/Project.zip")

#Unzip the file
unzip(zipfile="./Project/Project.zip",exdir="./Project")

#Get the list of Unzipped files that are in the folder UCI HAR Dataset
working_path <- file.path("./Project" , "UCI HAR Dataset")
files<-list.files(working_path, recursive=TRUE)

#Read data from the files

#Read the Activity files
ActivityTestData  <- read.table(file.path(working_path, "test" , "Y_test.txt" ), header = FALSE)
ActivityTrainData <- read.table(file.path(working_path, "train", "Y_train.txt"), header = FALSE)

#Read the Subject files
SubjectTrainData <- read.table(file.path(working_path, "train", "subject_train.txt"), header = FALSE)
SubjectTestData  <- read.table(file.path(working_path, "test" , "subject_test.txt"), header = FALSE)

#Read Fearures files
FeaturesTestData  <- read.table(file.path(working_path, "test" , "X_test.txt" ), header = FALSE)
FeaturesTrainData <- read.table(file.path(working_path, "train", "X_train.txt"), header = FALSE)

#Merges the training and the test data sets to create one data set

#Concatenate the data tables by rows
SubjectData <- rbind(SubjectTrainData, SubjectTestData)
ActivityData<- rbind(ActivityTrainData, ActivityTestData)
FeaturesData<- rbind(FeaturesTrainData, FeaturesTestData)

#Set names to variables
names(SubjectData)<-c("subject")
names(ActivityData)<- c("activity")
FeaturesNamesData <- read.table(file.path(working_path, "features.txt"), head=FALSE)
names(FeaturesData)<- FeaturesNamesData$V2

#Merge columns to get the data frame Data for all data
CombineData <- cbind(SubjectData, ActivityData)
Data <- cbind(FeaturesData, CombineData)

# Extracts only the measurements on the mean and standard deviation for each measurement
# Subset Name of Features by measurements on the mean and standard deviation
# Names of Features will be taken with “mean()” or “std()”

FeaturesNamesSubset<-FeaturesNamesData$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNamesData$V2)]

#Subset the data frame Data by seleted names of Features
selNames<-c(as.character(FeaturesNamesSubset), "subject", "activity" )
Data<-subset(Data,select=selNames)


#Read descriptive activity names from “activity_labels.txt”
ActivityLabels <- read.table(file.path(working_path, "activity_labels.txt"),header = FALSE)


#Appropriately labels the data set with descriptive variable names
#variables subject and  activity and names of the activities have been labelled using descriptive names.
#Names of Feteatures will labelled using descriptive variable names.

#prefix t is replaced by time
#prefix f is replaced by frequency
#Acc is replaced by Accelerometer
#BodyBody is replaced by Body
#Gyro is replaced by Gyroscope
#Mag is replaced by Magnitude

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))

#Creates a second tidy data set and ouput it
#This tidy data set will be created with the average of each variable 
#for each subject and each activity based on the data set in previous step.

TidyData<-aggregate(. ~subject + activity, Data, mean)
TidyData<-TidyData[order(Data2$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt", row.name=FALSE)

