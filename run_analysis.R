#The purpose of this project is to demonstrate the ability to (1) collect (2)work with (3) clean a data set

#Review Criteria
#1.The submitted data set is tidy.
#2.The Github repo contains the required scripts.
#3.GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
#4.The README that explains the analysis files is clear and understandable.
#5.The work submitted for this project is the work of the student who submitted it.

#CODE BOOK
#1 Check and create directory
if (!file.exists("getting_and_cleaning_data")){dir.create("getting_and_cleaning_data")}
#2 Set working directory
setwd('C:/Users/Osath/OneDrive/Documents/getting_and_cleaning_data_project/UCI HAR Dataset');

#2 Load the data into R for training data set
features<- read.table('./features.txt', header = FALSE);

activity_labels<-read.table('./activity_labels.txt', header =FALSE);

colnames(activity_labels)<-c("activId", "activType");

subject_train<-read.table('./train/subject_train.txt', header = FALSE);

colnames(subject_train)<-c("subjId");

x_train<-read.table('./train/x_train.txt', header = FALSE);

colnames(x_train)<-features[,2];

y_train<-read.table('./train/y_train.txt', header = FALSE);

colnames(y_train)<-"activId";

#3 Load the data into R for testing data set
subject_test<-read.table('./test/subject_test.txt', header = FALSE);
colnames(subject_test)<-c("subjId");
x_test<-read.table('./test/X_test.txt', header = FALSE);
colnames(x_test)<-features[,2];
y_test<-read.table('./test/y_test.txt', header = FALSE);
colnames(y_test)<-"activId";

#Question 1: Merge datasets
dataset_train<-cbind.data.frame( y_train, subject_train, x_train)
dataset_test<-cbind.data.frame( y_test, subject_test,x_test)
Master_set<-rbind(dataset_train,dataset_test)

#Question 2: Extracts only the measurements on the mean and standard deviation for each measurement
#First get all the appropriate data labels in one Master_set2_vector
LABELS<- colnames(Master_set);
Master_set2_vector <- (grepl("activId",LABELS) | grepl("subjId",LABELS) | 
                         grepl("mean",LABELS)|grepl("std",LABELS));
#Second subset only data with the appropriate column header
Master_set2 <- Master_set[Master_set2_vector==TRUE];

#Question 3: Uses descriptive activity names to name the activities in the data set

Master_set3 <- merge(Master_set2,activity_labels,by='activId',all.x=TRUE);
Master_set3$activId<-activity_labels[,2][match(Master_set3$activId, activity_labels[,1])] 

#Question 4: Appropriately labels the data set with descriptive variable names
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

#Question 5: From the data set in step 4, creates a second, independent tidy data set (Cleandata) with 
#the average of each variable for each activity and each subject
Master_set4 <- aggregate(. ~subjId + activId, Master_set3, mean)
Cleandata <- Master_set4[order(Master_set4$subjId, Master_set4$activId),]


#Clean data set extraction 
write.table(Cleandata, './Cleaned_data.txt',row.names=FALSE,sep='\t')
