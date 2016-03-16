# This Code Book explains all data/variables.

#### Data files
* Data files found in the ZIP file.
* y_train.txt		- Activity number for 'train' dataset. Values 1-6. It has 7352 rows.
* y_test.txt		- Activity number for 'test' dataset. Values 1-6. It has 2947 rows.

* X_train.txt		- Data measurement for 'train' dataset. It has 561 columns per row. It has 7352 rows.
* X_test.txt		- Data measurement for 'test' dataset. It has 561 columns per row. It has 2947 rows.

* subject_train.txt	- Subject (person) number for the 'train' dataset. Values 1-30. It has 7352 rows.
* subject_test.txt	- Subject (person) number for the 'test' dataset. Values 1-30. It has 2947 rows.

-------------

* activity_labels.txt	- Value/String pairs. Values 1-6. This can be used to convert activity number to activity label. It has 6 rows.

* features.txt		- It has 561 rows of value (1-156) and string pairs. The string is the measurement description string.

* features_info.txt	- Explanation of what the descriptive strings mean in features.txt.

* The above data files can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* A full description of these files can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones





#### Variables in run_analysis.R script file.
* These variables are assigned to the files path/filename.
    file1, file2, file3, file4, file5, file6, file7, file8

* my_train_data -- Data read from file1.
* my_train_activity_values -- Data read from file2.
* my_train_subject_values -- Data read from file3.

* my_test_data -- Data read from file4.
* my_test_activity_values -- Data read from file5.
* my_test_subject_values  -- Data read from file6.

* my_features_labels -- Data read from file7.
* my_activity_labels -- Data read from file8.

* my_activity_values -- Combines the test & train activity values.
* my_subject_values -- Combines the test & train subject values.

* my_data -- The dataset that has both the test & train data. The dataset after the labels are replaced with more descriptive labels.
* my_tidy_data -- The mean of the data is calculated per subject number and per activity label.


## Transformed data.frame 'my_data' labels.
* The below is the transformed labels which is more descriptive than the original labels.

subject_num
activity_label                                   
TimeBodyAccelerometerMean()-X                    
TimeBodyAccelerometerMean()-Y                    
TimeBodyAccelerometerMean()-Z                    
TimeBodyAccelerometerSTD()-X                     
TimeBodyAccelerometerSTD()-Y                     
TimeBodyAccelerometerSTD()-Z                     
TimeGravityAccelerometerMean()-X                 
TimeGravityAccelerometerMean()-Y                 
TimeGravityAccelerometerMean()-Z                 
TimeGravityAccelerometerSTD()-X                  
TimeGravityAccelerometerSTD()-Y                  
TimeGravityAccelerometerSTD()-Z                  
TimeBodyAccelerometerJerkMean()-X                
TimeBodyAccelerometerJerkMean()-Y                
TimeBodyAccelerometerJerkMean()-Z                
TimeBodyAccelerometerJerkSTD()-X                 
TimeBodyAccelerometerJerkSTD()-Y                 
TimeBodyAccelerometerJerkSTD()-Z                 
TimeBodyGyroscopeMean()-X                        
TimeBodyGyroscopeMean()-Y                        
TimeBodyGyroscopeMean()-Z                        
TimeBodyGyroscopeSTD()-X                         
TimeBodyGyroscopeSTD()-Y                         
TimeBodyGyroscopeSTD()-Z                         
TimeBodyGyroscopeJerkMean()-X                    
TimeBodyGyroscopeJerkMean()-Y                    
TimeBodyGyroscopeJerkMean()-Z                    
TimeBodyGyroscopeJerkSTD()-X                     
TimeBodyGyroscopeJerkSTD()-Y                     
TimeBodyGyroscopeJerkSTD()-Z                     
TimeBodyAccelerometerMagnitudeMean()             
TimeBodyAccelerometerMagnitudeSTD()              
TimeGravityAccelerometerMagnitudeMean()          
TimeGravityAccelerometerMagnitudeSTD()           
TimeBodyAccelerometerJerkMagnitudeMean()         
TimeBodyAccelerometerJerkMagnitudeSTD()          
TimeBodyGyroscopeMagnitudeMean()                 
TimeBodyGyroscopeMagnitudeSTD()                  
TimeBodyGyroscopeJerkMagnitudeMean()             
TimeBodyGyroscopeJerkMagnitudeSTD()              
FrequencyBodyAccelerometerMean()-X               
FrequencyBodyAccelerometerMean()-Y               
FrequencyBodyAccelerometerMean()-Z               
FrequencyBodyAccelerometerSTD()-X                
FrequencyBodyAccelerometerSTD()-Y                
FrequencyBodyAccelerometerSTD()-Z                
FrequencyBodyAccelerometerJerkMean()-X           
FrequencyBodyAccelerometerJerkMean()-Y           
FrequencyBodyAccelerometerJerkMean()-Z           
FrequencyBodyAccelerometerJerkSTD()-X            
FrequencyBodyAccelerometerJerkSTD()-Y            
FrequencyBodyAccelerometerJerkSTD()-Z            
FrequencyBodyGyroscopeMean()-X                   
FrequencyBodyGyroscopeMean()-Y                   
FrequencyBodyGyroscopeMean()-Z                   
FrequencyBodyGyroscopeSTD()-X                    
FrequencyBodyGyroscopeSTD()-Y                    
FrequencyBodyGyroscopeSTD()-Z                    
FrequencyBodyAccelerometerMagnitudeMean()        
FrequencyBodyAccelerometerMagnitudeSTD()         
FrequencyBodyBodyAccelerometerJerkMagnitudeMean()
FrequencyBodyBodyAccelerometerJerkMagnitudeSTD() 
FrequencyBodyBodyGyroscopeMagnitudeMean()        
FrequencyBodyBodyGyroscopeMagnitudeSTD()         
FrequencyBodyBodyGyroscopeJerkMagnitudeMean()    
FrequencyBodyBodyGyroscopeJerkMagnitudeSTD() 


