#libraries used
library(dplyr)
getwd()#not including my wd, in case of trying to replicate, the user should define its own directory
setwd("")#set your wd but taking in mind the read.table function below

#this assumes that the selected directory has the extracted folder on it
#Reading and Assigning the train and test datasets, also the respective subjects plus the features and activities
#important to note that the first one to be read txt must be the features.txt
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n","functions"))
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))


#1. Merges the training and the test sets to create one data set.
Train <- cbind(subject_train,y_train,x_train)
Test <- cbind(subject_test,y_test,x_test)
M_data <- rbind(Train, Test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

Ext_data <- M_data %>% select(subject, code, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set

Ext_data$code <- activities[Ext_data$code, 2]

#4. Appropriately labels the data set with descriptive variable names.
#
names(Ext_data)
names(Ext_data)[2] = "Activity"
names(Ext_data)<-gsub("Acc", "Accelerometer", names(Ext_data))
names(Ext_data)<-gsub("Gyro", "Gyroscope", names(Ext_data))
names(Ext_data)<-gsub("BodyBody", "Body", names(Ext_data))
names(Ext_data)<-gsub("Mag", "Magnitude", names(Ext_data))
names(Ext_data)<-gsub("^t", "Time", names(Ext_data))
names(Ext_data)<-gsub("^f", "Frequency", names(Ext_data))
names(Ext_data)<-gsub("tBody", "TimeBody", names(Ext_data))
names(Ext_data)<-gsub("-mean()", "Mean", names(Ext_data), ignore.case = TRUE)
names(Ext_data)<-gsub("-std()", "STD", names(Ext_data), ignore.case = TRUE)
names(Ext_data)<-gsub("-freq()", "Frequency", names(Ext_data), ignore.case = TRUE)
names(Ext_data)<-gsub("angle", "Angle", names(Ext_data))
names(Ext_data)<-gsub("gravity", "Gravity", names(Ext_data))


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

IndData <- Ext_data %>%
      group_by(subject, Activity) %>%
      summarise_all(funs(mean))
write.table(IndData, "IndependentData.txt", row.name=FALSE)


