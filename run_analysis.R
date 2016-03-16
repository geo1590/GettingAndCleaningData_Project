
###
# This script is for the "Getting and Cleaning Data Course Project". 
#  
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare 
# tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the 
# project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your 
# script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work 
# that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.
#  
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies 
# like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to 
# from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full 
# description is available at the site where the data was obtained:
#  
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#  
# Here are the data for the project:
#  
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#  
#  

my_func1 <- function(x) {
    ### 
    #     Instructions
    #     ---------------
    #     You should create one R script called run_analysis.R that does the following.
    #
    #     1. Merges the training and the test sets to create one data set.
    #     2. Extracts only the measurements on the mean and standard deviation for each measurement.
    #     3. Uses descriptive activity names to name the activities in the data set
    #     4. Appropriately labels the data set with descriptive variable names.
    #     5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    #
    
    
    library(data.table)
    library(dplyr)

    ### Step #1: Merge the tain and test data.

    # Define the files.
    file1 <- "data/train/X_train.txt"
    file2 <- "data/train/y_train.txt"
    file3 <- "data/train/subject_train.txt"
    file4 <- "data/test/X_test.txt"
    file5 <- "data/test/y_test.txt"
    file6 <- "data/test/subject_test.txt"
    file7 <- "data/features.txt"
    file8 <- "data/activity_labels.txt"


    # Read in the "train" data.
    my_train_data <- read.delim(file1, header=FALSE, sep="")
    my_train_activity_values <- read.delim(file2, header=FALSE, sep="")
    my_train_subject_values <- read.delim(file3, header=FALSE, sep="")

    # Read in the "test" data.
    my_test_data <- read.delim(file4, header=FALSE, sep="")
    my_test_activity_values <- read.delim(file5, header=FALSE, sep="")
    my_test_subject_values <- read.delim(file6, header=FALSE, sep="")

    # Read the other data.
    my_features_labels <- read.delim(file7, header=FALSE, sep="")
    my_activity_labels <- read.delim(file8, header=FALSE, sep="")


    # Merge them.
    my_data <- rbind(my_train_data, my_test_data)
    my_activity_values <- rbind(my_train_activity_values, my_test_activity_values)
    my_subject_values <- rbind(my_train_subject_values, my_test_subject_values)
    my_data <- cbind(my_activity_values, my_subject_values, my_data)

    ### Step #3: Use descriptive activity names to name the activities in the data set.
    # my_data$activity_label <- my_activity_labels[my_data[1], 2]
    my_data[,1] <- my_activity_labels[my_data[,1], 2]

    ### Step #4: Appropriately label the data set with descriptive variable names.
    my_colnames <- as.character(my_features_labels$V2)
    my_colnames <- c('activity_label', 'subject_number', my_colnames)
    colnames(my_data) <- my_colnames



    ### Step #2: Extract on the measurements on the mean and standard deviation for each measurement.
    my_data <- my_data[,c(1, 2, grep("-mean[(][)]|-std[(][)]", names(my_data)))]

    names(my_data) <- gsub("Acc", "Accelerometer", names(my_data))
    names(my_data) <- gsub("-mean()", "Mean", names(my_data))
    names(my_data) <- gsub("-std()", "STD", names(my_data))
    names(my_data) <- gsub("-meanFreq()", "MeanFreq", names(my_data))
    names(my_data) <- gsub("tBody", "TimeBody", names(my_data))
    names(my_data) <- gsub("^t", "Time", names(my_data))
    names(my_data) <- gsub("^f", "Frequency", names(my_data))
    names(my_data) <- gsub("Gyro", "Gyroscope", names(my_data))
    names(my_data) <- gsub("Mag", "Magnitude", names(my_data))


    ### Step #5: From the data set in step 4, create a second, independent tidy data set with the average of each 
    #            variable for each activity and each subject.
    my_data$subject_number <- as.factor(my_data$subject_number)
    my_data <- data.table(my_data)
    my_tidy_data <- aggregate(. ~subject_number + activity_label, my_data, mean)
    my_tidy_data <- my_tidy_data[order(my_tidy_data$subject_number, my_tidy_data$activity_label),]
    write.table(my_tidy_data, 'my_tidy_data.txt', row.names=FALSE)
     
}



