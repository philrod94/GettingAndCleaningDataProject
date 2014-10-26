# load common data
labels_features <- read.table("./data/UCI HAR Dataset/features.txt",fill=FALSE, strip.white=TRUE)
labels_activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", strip.white=TRUE,col.names=c("activity_id","activity_label"))  


# load test data
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",col.names=c("activity_id"),fill=FALSE, strip.white=TRUE)
x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt",fill=TRUE, strip.white=TRUE,col.names=labels_features[,2])
subject_test <-  read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names=c("subject_id"),fill=FALSE,strip.white=TRUE)  


# load train data
y_train = read.table("./data/UCI HAR Dataset/train/y_train.txt",col.names=c("activity_id"),fill=FALSE, strip.white=TRUE)
x_train = read.table("./data/UCI HAR Dataset/train/x_train.txt",fill=TRUE, strip.white=TRUE,col.names=labels_features[,2])
subject_train =  read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names=c("subject_id"),fill=FALSE,strip.white=TRUE)

# merge the test and train data

subject_merge <- rbind(subject_test,subject_train)
y_merge <- rbind(y_test,y_train)
x_merge <- rbind(x_test,x_train)

# join the activities with the activity labels
y_merge <- merge(y_merge, labels_activity)

# create the main data set with all the columns (subject_id, activity_label, mean and mad variables)
data_set <- cbind(subject_merge, y_merge$activity_label, x_merge[,grep("mad|mean",as.character(labels_features[,2]))])
names(data_set)[2] <- "activity_label"

# removing intermediary data
rm(labels_features,labels_activity,y_test,x_test,subject_test,y_train,x_train,subject_train,subject_merge,y_merge,x_merge)

# generates the tidy data from main data set
require(plyr)
data_split <- ddply(data_set, c("subject_id","activity_label"), function(df)sapply(df[, 3:81],mean))
data_split
