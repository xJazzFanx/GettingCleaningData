
library(dataMaid)
library(tidyverse)

#Variable names for observations used to identify readings from X_test and X_train files
Features<- read.table("./features.txt", colClasses = c("character"), header = FALSE)

#Read data files into data frames
SubjectTest.df<- read.table("./test/subject_test.txt", sep = " ", header = FALSE)
SubjectTrain.df<- read.table("./train/subject_train.txt", sep = " ", header = FALSE)

TestSet.df<- read.table("./test/X_test.txt", header = FALSE)
TestLabels.df<-read.table("./test/y_test.txt", header = FALSE)

TrainingSet.df<- read.table("./train/X_train.txt", header = FALSE)
TrainingLabels.df<- read.table("./train/y_train.txt", header = FALSE)

ActivityLabels.df<- read.table("./activity_labels.txt", sep = "", col.names = c("ActivityId", "Activity"), header = FALSE)

#Combine Testing and Training data frames
DataTestingTemp.df<- cbind(TestSet.df, SubjectTest.df)
DataTesting.df<- cbind(DataTestingTemp.df, TestLabels.df)
DataTrainingTemp.df<- cbind(TrainingSet.df, SubjectTrain.df)
DataTraining.df<- cbind(DataTrainingTemp.df, TrainingLabels.df)

#Merges the training and the test sets to create one data set.
MergedData.df<- rbind(DataTesting.df, DataTraining.df)


AccGyroLabels <- rbind(rbind(Features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(MergedData.df) <- AccGyroLabels

#Extracts only the measurements on the mean and standard deviation for each measurement.
DataMeanStdDev.df<- MergedData.df[,grepl("mean|std|Subject|ActivityId", names(MergedData.df))]


#Uses descriptive activity names to name the activities in the data set.
DataMeanStdDev.df<- join(DataMeanStdDev.df, ActivityLabels.df, by = "ActivityId", match = "first")
DataMeanStdDev.df<- DataMeanStdDev.df[,-1]

#Appropriately labels the data set with descriptive variable names.
names(DataMeanStdDev.df)<-gsub("^t", "TimeDomainSignal", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("^f", "FrequencyDomainSignal", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("mean", "Mean", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("std", "StandardDeviation", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("freq", "Frequency", names(DataMeanStdDev.df))

names(DataMeanStdDev.df)<-gsub("BodyBody", "Body", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("Acc", "Acceleration", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("GyroJerk", "AngularVelocity", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("Gyro", "Gyroscope", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("Mag", "Magnitude", names(DataMeanStdDev.df))

#Clean up character vectors - remove parentheses, periods, and dashes from variable names
names(DataMeanStdDev.df)<-gsub("\\()","", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("\\.", "", names(DataMeanStdDev.df))
names(DataMeanStdDev.df)<-gsub("-","", names(DataMeanStdDev.df))

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
SubjActivityAverage<- DataMeanStdDev.df %>%
    group_by(Subject, Activity) %>%
    summarize_all(mean)
write.table(SubjActivityAverage, file = "SubjActivityAverage.txt", row.names = FALSE)

makeCodebook(SubjActivityAverage)







