# Getting-and-Cleaning-data
Getting and Cleaning data Final Project: READ ME

In the "getting and cleaning data" repository you will find 4 files:
- Cleaned_data:tidy data set 
- CodeBook.md:  that describes the variables, the data, and any transformations or work that was performed to clean up the data
- README.md: scripts
- run_analysis.R: scripts with all the code necessary to produce the tidy data set

This 'README.md' file provides the reader with information about the repository and its files. Make sure to read the CodeBook.md prior to using the 'run_analysis.R' file.

#Information about the raw data acquisition
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

Information about the CodeBook.md
The CodeBook describes the variables, the data, and any transformations or work that was performed to clean up the data. It also contains an explaination to the purpose of each code

Information about run_analysis.R
The run analysis file was created to perform the follwing steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Prior to using the 'run_analysis.R' file make sure to properly set up the working directory. Once the working directory is properly set-up, the code can be copied into R and ran.

Information about tidy data set 'Cleaned_data.txt'
The 'Cleaned_data.txt' file contains the the output of the 'run_analysis.R' on the data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

