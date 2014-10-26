Original data information: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Original data archive:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Used files from data archive:
  - ./data/UCI HAR Dataset/features.txt
  - ./data/UCI HAR Dataset/activity_labels.txt
  - ./data/UCI HAR Dataset/test/y_test.txt
  - ./data/UCI HAR Dataset/test/x_test.txt
  - ./data/UCI HAR Dataset/test/subject_test.txt
  - ./data/UCI HAR Dataset/train/y_train.txt
  - ./data/UCI HAR Dataset/train/x_train.txt
  - ./data/UCI HAR Dataset/train/subject_train.txt
  
Execution:
- run the run_analysis.R script after dearchiving the data into the working directory data folder

Setps:
#1 loading reference data
- creating table labels_features from file ./data/UCI HAR Dataset/features.txt
- creating table labels_activity from file ./data/UCI HAR Dataset/activity_labels.txt

#2 loading test data
- creating table y_test from file ./data/UCI HAR Dataset/test/y_test.txt using activity_id as variable name
- creating table x_test from file ./data/UCI HAR Dataset/test/x_test.txt using labels_features for variable names
- creating table subject_test from file ./data/UCI HAR Dataset/test/subject_test.txt using subject_id as variable name

#3 loading train data
- creating table y_train from file ./data/UCI HAR Dataset/train/y_train.txt using activity_id as variable name
- creating table x_train from file ./data/UCI HAR Dataset/train/x_train.txt using labels_features for variable names
- creating table subject_train from file ./data/UCI HAR Dataset/train/subject_train.txt using subject_id as variable name

#4 merging test and train data
- creating table y_merge from row merging of y_test and y_train
- creating table x_merge from row merging of x_test and x_train
- creating table subject_merge from row merging of subject_test and subject_train 

#5 joining activities with the activity labels
- joining tables y_merge and labels_activity into y_merge

#6 building main data set
- creating table data_set from column merging of subject_merge, y_merge$activity_label, filter of x_merge variables containing mean or mad in the name 
- changing variable name 2 (y_merge$activity_label) to activity_label

#7 removing intermediary data
- removing tables labels_features,labels_activity,y_test,x_test,subject_test,y_train,x_train,subject_train,subject_merge,y_merge,x_merge

#8 creating the tidy data with the average of each variable for each activity and each subject
- creating data_split table by grouping data_set table based on subject_id and activity_label to apply mean function on all the other variables
- returning data_split