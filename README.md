
# Analysis of the run_analysis.R script.

#### Load libraries
These are needed for the script to run.
```{r}
    library(data.table)
    library(dplyr)
```

#### Define all the files.
These files were obtained via:
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
More info can be found here:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
```{r}
    file1 <- "data/train/X_train.txt"
    file2 <- "data/train/y_train.txt"
    file3 <- "data/train/subject_train.txt"
    file4 <- "data/test/X_test.txt"
    file5 <- "data/test/y_test.txt"
    file6 <- "data/test/subject_test.txt"
    file7 <- "data/features.txt"
    file8 <- "data/activity_labels.txt"
```

#### Read in the "train" data.
The training data is a space delimited text file, so the sep="" is used.
```{r}
    my_train_data <- read.delim(file1, header=FALSE, sep="")
    my_train_activity_values <- read.delim(file2, header=FALSE, sep="")
    my_train_subject_values <- read.delim(file3, header=FALSE, sep="")
```

#### Read in the "test" data.
The test data is a space delimited text file, so the sep="" is used.
```{r}
    # Read in the "test" data.
    my_test_data <- read.delim(file4, header=FALSE, sep="")
    my_test_activity_values <- read.delim(file5, header=FALSE, sep="")
    my_test_subject_values <- read.delim(file6, header=FALSE, sep="")
```

#### Read in the features labels and activity label data.
The features label is a short description of the data measurement. The activity label is a string showing the activity performed.
```{r}
    my_features_labels <- read.delim(file7, header=FALSE, sep="")
    my_activity_labels <- read.delim(file8, header=FALSE, sep="")
```

#### Merge the "train" and "test" data.
Merge the two data set. The "test" data goes under the "train" data set. Both data sets have the same number of columns.
```{r}
    my_data <- rbind(my_train_data, my_test_data)
```

#### Add the activity values and subject values to the merged data set.
The activity values are integers denoting the activity performed. The subject values are integers denoting the subject (person) performing the experiment.
```{r}
    my_activity_values <- rbind(my_train_activity_values, my_test_activity_values)
    my_subject_values <- rbind(my_train_subject_values, my_test_subject_values)
    my_data <- cbind(my_activity_values, my_subject_values, my_data)
```

## Replace activity values with more descriptive activity labels.
The activity label's first column is the activity value (integer) and second column is the activity label being performed. This can be used to substitute an activity value with a more descriptive activity label (text).
```{r}
    my_data[,1] <- my_activity_labels[my_data[,1], 2]
```

## Add the activity label and subject number to the merged data set's column names.
The activity label and subject number are add as column one and two to the data set. They have the same number of rows as the data set.
```{r}
    my_colnames <- as.character(my_features_labels$V2)
    my_colnames <- c('activity_label', 'subject_number', my_colnames)
    colnames(my_data) <- my_colnames
```

## Extract/use only the columns that use mean and standard deviation.
Since we only want the measurements that calculate the mean or standard deviation, we extract those columns and leave out the rest, but include the activity label and subject number columns.
```{r}
    my_data <- my_data[,c(1, 2, grep("-mean[(][)]|-std[(][)]", names(my_data)))]
```

#### Rename some column names with more descriptive text.
Some of the column names can be renamed to give a more descriptive meaning. To do this, a search & replace function is used on the data sets column names and then reassigned back.
```{r}
    names(my_data) <- gsub("Acc", "Accelerometer", names(my_data))
    names(my_data) <- gsub("-mean()", "Mean", names(my_data))
    names(my_data) <- gsub("-std()", "STD", names(my_data))
    names(my_data) <- gsub("-meanFreq()", "MeanFreq", names(my_data))
    names(my_data) <- gsub("tBody", "TimeBody", names(my_data))
    names(my_data) <- gsub("^t", "Time", names(my_data))
    names(my_data) <- gsub("^f", "Frequency", names(my_data))
    names(my_data) <- gsub("Gyro", "Gyroscope", names(my_data))
    names(my_data) <- gsub("Mag", "Magnitude", names(my_data))
```

#### Create a separate data set that is tidy with the average measurement for each activity and each subject.
The mean for each column measurement must be calculated grouped by activity labels and subject numbers. To do this, the data.table() is used.
```{r}
    my_data$subject_number <- as.factor(my_data$subject_number)
    my_data <- data.table(my_data)
    my_tidy_data <- aggregate(. ~subject_number + activity_label, my_data, mean)
    my_tidy_data <- my_tidy_data[order(my_tidy_data$subject_number, my_tidy_data$activity_label),]
```






