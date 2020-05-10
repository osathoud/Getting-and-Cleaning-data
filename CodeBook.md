---
title: "CodeBook"
author: "Ornella Sathoud"
date: "5/9/2020"
output:
  word_document: default
  pdf_document: default
  html_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

#Code Book: Getting and Cleaning Data

This code book provides the reader with a description of:
- The origin of the data
- the variables in the run analysis
- the data set called Cleaned_data.txt
- all transformation performed 

The data was obtained from the following "data link": https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data set  is described in the following  link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration 
and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding 
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed 
to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features 
was obtained by calculating variables from the time and frequency domain.
Check the README.txt file for further details about this dataset.
A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the link below:
https://www.youtube.com/watch?v=XOEN9W05_4A
An updated version of this dataset can be found at the link following below:
http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions
This version provides the original raw inertial signals from the smartphone sensors, instead of the ones pre-processed into windows 
which were provided in version 1. This change was done in order to be able to make online tests with the raw data. Moreover, 
the activity labels were updated in order to include postural transitions that were not part of the previous version of the dataset.

The "data link" lead to the following files: 
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

####Notes:
-Features are normalized and bounded within [-1,1].
-Each feature vector is a row on the 'X' and 'y' files.
-The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
-The gyroscope units are radian per second (rad/seg).

First check and create directory, then set working directory
```{r}
if (!file.exists("getting_and_cleaning_data")){dir.create("getting_and_cleaning_data")}
setwd('C:/Users/Osath/OneDrive/Documents/getting_and_cleaning_data_project/UCI HAR Dataset');
```

Once the data were loaded into R, 
```{r}
features<- read.table('./features.txt', header = FALSE);

activity_labels<-read.table('./activity_labels.txt', header =FALSE);

colnames(activity_labels)<-c("activId", "activType");

subject_train<-read.table('./train/subject_train.txt', header = FALSE);

colnames(subject_train)<-c("subjId");

x_train<-read.table('./train/x_train.txt', header = FALSE);

colnames(x_train)<-features[,2];

y_train<-read.table('./train/y_train.txt', header = FALSE);

colnames(y_train)<-"activId";

```

the data were transformed in the following order with the run_analysis.md R script:
- Merges the training and the test sets to create one data set.
Using cbind commands, y_train.txt, subject_train.txt and x_train.txt were bound together to form "dataset_train"
Using cbind commands, y_test.txt, subject_test.txt, and x_test.txt were bound together to form "dataset_test"
Both "dataset_train" and "dataset_test" were bound to form "Master_set" using rbind

```{r}
subject_test<-read.table('./test/subject_test.txt', header = FALSE);
colnames(subject_test)<-c("subjId");
x_test<-read.table('./test/X_test.txt', header = FALSE);
colnames(x_test)<-features[,2];
y_test<-read.table('./test/y_test.txt', header = FALSE);
colnames(y_test)<-"activId";
dataset_train<-cbind.data.frame( y_train, subject_train, x_train)
dataset_test<-cbind.data.frame( y_test, subject_test,x_test)
Master_set<-rbind(dataset_train,dataset_test)
```

- Extracts only the measurements on the mean and standard deviation for each measurement.
The information were extracted using the "grepl" function, after creating a vector "Master_set2_vector": that held all the necessary information into a the matrix "Master_set2"
```{r}
LABELS<- colnames(Master_set);
Master_set2_vector <- (grepl("activId",LABELS) | grepl("subjId",LABELS) | 
                         grepl("mean",LABELS)|grepl("std",LABELS));

Master_set2 <- Master_set[Master_set2_vector==TRUE];
```

- Uses descriptive activity names to name the activities in the data set
A new matrix called "Master_set3" was created to hold "Master_set2" properly labeld

```{r}
Master_set3 <- merge(Master_set2,activity_labels,by='activId',all.x=TRUE);
Master_set3$activId<-activity_labels[,2][match(Master_set3$activId, activity_labels[,1])] 
```

- Appropriately labels the data set with descriptive variable names.
Using the 'gsub' function, the acronyms were converted to their full spelling for proper labelling of the variables
```{r}
names(Master_set3)<-gsub("Acc", "Accelerometer", names(Master_set3))
names(Master_set3)<-gsub("Gyro", "Gyroscope", names(Master_set3))
names(Master_set3)<-gsub("BodyBody", "Body", names(Master_set3))
names(Master_set3)<-gsub("Mag", "Magnitude", names(Master_set3))
names(Master_set3)<-gsub("^t", "Time", names(Master_set3))
names(Master_set3)<-gsub("^f", "Frequency", names(Master_set3))
names(Master_set3)<-gsub("tBody", "TimeBody", names(Master_set3))
names(Master_set3)<-gsub("-freq()", "Frequency", names(Master_set3))
names(Master_set3)<-gsub("angle", "Angle", names(Master_set3))
names(Master_set3)<-gsub("gravity", "Gravity", names(Master_set3))
names(Master_set3)<-gsub("mean", "Mean", names(Master_set3))
names(Master_set3)<-gsub("std", "StandardDeviation", names(Master_set3))
```

- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
each activity and each subject.
The 'aggregate' function helped with calculating the average of each variable into "Master_set4" matrix, and then the order function helped with oraginzing the data into matrix "Cleandata"
```{r}
Master_set4 <- aggregate(. ~subjId + activId, Master_set3, mean)
Cleandata <- Master_set4[order(Master_set4$subjId, Master_set4$activId),]
```


- The final data set called "cleaned_data.txt" was created from the matrix "Cleandata"
```{r}
write.table(Cleandata, './Cleaned_data.txt',row.names=FALSE,sep='\t')
```
