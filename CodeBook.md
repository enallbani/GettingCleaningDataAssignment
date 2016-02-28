**Code Book**

This code book describes the original data set and what was done to
"clean up" these data in order to produce tidy data sets required for
this course project.

**Overview**

Source of the original data:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Full Description at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

**Files in the original data set**

The original data set contains these files:

-   UCI HAR Dataset/activity\_labels.txt

-   UCI HAR Dataset/features.txt

-   UCI HAR Dataset/features\_info.txt

-   UCI HAR Dataset/README.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_acc\_x\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_acc\_y\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_acc\_z\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_gyro\_x\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_gyro\_y\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/body\_gyro\_z\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/total\_acc\_x\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/total\_acc\_y\_test.txt

-   UCI HAR Dataset/test/Inertial Signals/total\_acc\_z\_test.txt

-   UCI HAR Dataset/test/subject\_test.txt

-   UCI HAR Dataset/test/X\_test.txt

-   UCI HAR Dataset/test/y\_test.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_acc\_x\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_acc\_y\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_acc\_z\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_gyro\_x\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_gyro\_y\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/body\_gyro\_z\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/total\_acc\_x\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/total\_acc\_y\_train.txt

-   UCI HAR Dataset/train/Inertial Signals/total\_acc\_z\_train.txt

-   UCI HAR Dataset/train/subject\_train.txt

-   UCI HAR Dataset/train/X\_train.txt

-   UCI HAR Dataset/train/y\_train.txt

The data files consist of some files containing labels and column
(variable) names and other files containing data values. The data values
consist of subject numbers (30), activity types (6), coded as the
integers 1-6, and sensor signals, from a 561-column "feature vector".

**Processing**

To clean-up the data of this project we need to combine into a single
data set the “test” and “train” data set. Only the measurements on the
mean and standard deviation for each measurement are included, (based on
assessment requirement)

The script run\_analysis.R performs the following process to clean up
the data and create tiny data sets:

**Reading the data**

Reading is performed using read.table():

Read data from the files:

1.  Read Activity text files (“Y\_train.txt” and “Y\_test.txt”) into
    data frames ActivityTrainData and ActivityTestData

2.  Read Subject text files (“subject\_train.txt”
    and “subject\_test.txt”) into data frames SubjectTrainData and
    SubjectTestData

3.  Read Features text files (“X\_train.txt” and “X\_test.txt”) into
    data frames FeaturesTrainData and FeaturesTestData)

4.  Read descriptive activity names from “activity\_labels.txt”

**Merging the Data**

Merges the training and the test data sets to create one data set
concatenating the data tables by rows (rbind) into variables:

-   SubjectData

-   ActivityData

-   FeaturesData

Merge columns to get the data frame Data for all data:

-   CombineData

-   Data

**Set Descriptive Names**

-   prefix t is replaced by time

-   prefix f is replaced by frequency

-   Acc is replaced by Accelerometer

-   BodyBody is replaced by Body

-   Gyro is replaced by Gyroscope

-   Mag is replaced by Magnitude

**Output file**

The resulting data sets are summarized as follows:

-   Data

-   TidyData

**Data** is the data set with cleaned-up column names and labels, and
only the mean and standard deviation values from the "feature vector"
data.

**TidyData** is the aggregated data set, grouped by subject and activity
and is exported as a text file, "tidydata.txt".

This file can be imported and viewed with these commands:

-   data &lt;- read.table("tidydata.txt", header = TRUE)

-   View(data)


