
# Analysis of the run_analysis.R script.

## Load libraries
```{r}
    library(data.table)
    library(dplyr)
```


## Define all the files.
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

## Read in the "train" data.
```{r}
    my_train_data <- read.delim(file1, header=FALSE, sep="")
    my_train_activity_values <- read.delim(file2, header=FALSE, sep="")
    my_train_subject_values <- read.delim(file3, header=FALSE, sep="")
```


## Read in the "test" data.
```{r}
    # Read in the "test" data.
    my_test_data <- read.delim(file4, header=FALSE, sep="")
    my_test_activity_values <- read.delim(file5, header=FALSE, sep="")
    my_test_subject_values <- read.delim(file6, header=FALSE, sep="")
```

## Read in the features labels and activity label data.
```{r}
    my_features_labels <- read.delim(file7, header=FALSE, sep="")
    my_activity_labels <- read.delim(file8, header=FALSE, sep="")
```

## Merge the "train" and "test" data.
```{r}
    my_data <- rbind(my_train_data, my_test_data)
```

## Add the activity values and subject values to the merged data set.
```{r}
    my_activity_values <- rbind(my_train_activity_values, my_test_activity_values)
    my_subject_values <- rbind(my_train_subject_values, my_test_subject_values)
    my_data <- cbind(my_activity_values, my_subject_values, my_data)
```

## Replace activity values with more descriptive activity labels.
```{r}
    my_data[,1] <- my_activity_labels[my_data[,1], 2]
```

## Add the activity label and subject number to the merged data set's column names.
```{r}
    my_colnames <- as.character(my_features_labels$V2)
    my_colnames <- c('activity_label', 'subject_number', my_colnames)
    colnames(my_data) <- my_colnames
```

## Extract/use only the columns that use mean and standard deviation.
```{r}
    my_data <- my_data[,c(1, 2, grep("-mean[(][)]|-std[(][)]", names(my_data)))]
```

## Rename some column names with more descriptive text.
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

## Create a separate data set that is tidy with the average measurement for each activity and each subject.
```{r}
    my_data$subject_number <- as.factor(my_data$subject_number)
    my_data <- data.table(my_data)
    my_tidy_data <- aggregate(. ~subject_number + activity_label, my_data, mean)
    my_tidy_data <- my_tidy_data[order(my_tidy_data$subject_number, my_tidy_data$activity_label),]
```






