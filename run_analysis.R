#download zipfile and save the unzipped files to local document
#load library dplyr

library(dplyr)
library(data.table)

#read supporting metadata - features and the name of the activities 
#and label them as featureNames / ActivityLabels

featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Format training and test data sets taken from 3 different text files
#read TRAINING DATA

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#read TEST DATA
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

#after reading and calling each individual txt file - ready to merge data

############
#TASK 1 of 5 - Merges the training and the test sets to create one data set
############
#combine training/test data sets into SUBJECT, ACTIVITY and FEATURES

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#name the columns - features data set - now featureNames (see line 10)

colnames(features) <- t(featureNames[2])

#Merge the data: subject, activity, features (line 29-31). 
#Call merged data as CompleteTable

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeTable <- cbind(features,activity,subject)

############
#TASK 2 of 5 - Extracts only the measurements on the mean and standard deviation for each measurement
############

#Extract the column indices that have either mean or std in them
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeTable), ignore.case=TRUE)

#Add activity and subject columns to the list and look at the dimension of CompleteTable
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeTable)

#create extractedData with the selected columns in requiredColumns. And again, we look at the dimension of requiredColumns.
extractedData <- completeTable[,requiredColumns]
dim(extractedData)

############
#TASK 3 of 5 - Uses descriptive activity names to name the activities in the data set
############

#The activity field in extractedData is originally of numeric type. We need to change its type to character so that it can accept activity names. The activity names are taken from metadata activityLabels.
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
extractedData$Activity <- as.factor(extractedData$Activity)

############
#TASK 4 of 5 - Appropriately labels the data set with descriptive variable names
############

#Here are the names of the variables in extractedData
names(extractedData)

##  [1] "tBodyAcc-mean()-X"                   
##  [2] "tBodyAcc-mean()-Y"                   
##  [3] "tBodyAcc-mean()-Z"                   
##  [4] "tBodyAcc-std()-X"                    
##  [5] "tBodyAcc-std()-Y"                    
##  [6] "tBodyAcc-std()-Z"                    
##  [7] "tGravityAcc-mean()-X"                
##  [8] "tGravityAcc-mean()-Y"                
##  [9] "tGravityAcc-mean()-Z"                
## [10] "tGravityAcc-std()-X"                 
## [11] "tGravityAcc-std()-Y"                 
## [12] "tGravityAcc-std()-Z"                 
## [13] "tBodyAccJerk-mean()-X"               
## [14] "tBodyAccJerk-mean()-Y"               
## [15] "tBodyAccJerk-mean()-Z"               
## [16] "tBodyAccJerk-std()-X"                
## [17] "tBodyAccJerk-std()-Y"                
## [18] "tBodyAccJerk-std()-Z"                
## [19] "tBodyGyro-mean()-X"                  
## [20] "tBodyGyro-mean()-Y"                  
## [21] "tBodyGyro-mean()-Z"                  
## [22] "tBodyGyro-std()-X"                   
## [23] "tBodyGyro-std()-Y"                   
## [24] "tBodyGyro-std()-Z"                   
## [25] "tBodyGyroJerk-mean()-X"              
## [26] "tBodyGyroJerk-mean()-Y"              
## [27] "tBodyGyroJerk-mean()-Z"              
## [28] "tBodyGyroJerk-std()-X"               
## [29] "tBodyGyroJerk-std()-Y"               
## [30] "tBodyGyroJerk-std()-Z"               
## [31] "tBodyAccMag-mean()"                  
## [32] "tBodyAccMag-std()"                   
## [33] "tGravityAccMag-mean()"               
## [34] "tGravityAccMag-std()"                
## [35] "tBodyAccJerkMag-mean()"              
## [36] "tBodyAccJerkMag-std()"               
## [37] "tBodyGyroMag-mean()"                 
## [38] "tBodyGyroMag-std()"                  
## [39] "tBodyGyroJerkMag-mean()"             
## [40] "tBodyGyroJerkMag-std()"              
## [41] "fBodyAcc-mean()-X"                   
## [42] "fBodyAcc-mean()-Y"                   
## [43] "fBodyAcc-mean()-Z"                   
## [44] "fBodyAcc-std()-X"                    
## [45] "fBodyAcc-std()-Y"                    
## [46] "fBodyAcc-std()-Z"                    
## [47] "fBodyAcc-meanFreq()-X"               
## [48] "fBodyAcc-meanFreq()-Y"               
## [49] "fBodyAcc-meanFreq()-Z"               
## [50] "fBodyAccJerk-mean()-X"               
## [51] "fBodyAccJerk-mean()-Y"               
## [52] "fBodyAccJerk-mean()-Z"               
## [53] "fBodyAccJerk-std()-X"                
## [54] "fBodyAccJerk-std()-Y"                
## [55] "fBodyAccJerk-std()-Z"                
## [56] "fBodyAccJerk-meanFreq()-X"           
## [57] "fBodyAccJerk-meanFreq()-Y"           
## [58] "fBodyAccJerk-meanFreq()-Z"           
## [59] "fBodyGyro-mean()-X"                  
## [60] "fBodyGyro-mean()-Y"                  
## [61] "fBodyGyro-mean()-Z"                  
## [62] "fBodyGyro-std()-X"                   
## [63] "fBodyGyro-std()-Y"                   
## [64] "fBodyGyro-std()-Z"                   
## [65] "fBodyGyro-meanFreq()-X"              
## [66] "fBodyGyro-meanFreq()-Y"              
## [67] "fBodyGyro-meanFreq()-Z"              
## [68] "fBodyAccMag-mean()"                  
## [69] "fBodyAccMag-std()"                   
## [70] "fBodyAccMag-meanFreq()"              
## [71] "fBodyBodyAccJerkMag-mean()"          
## [72] "fBodyBodyAccJerkMag-std()"           
## [73] "fBodyBodyAccJerkMag-meanFreq()"      
## [74] "fBodyBodyGyroMag-mean()"             
## [75] "fBodyBodyGyroMag-std()"              
## [76] "fBodyBodyGyroMag-meanFreq()"         
## [77] "fBodyBodyGyroJerkMag-mean()"         
## [78] "fBodyBodyGyroJerkMag-std()"          
## [79] "fBodyBodyGyroJerkMag-meanFreq()"     
## [80] "angle(tBodyAccMean,gravity)"         
## [81] "angle(tBodyAccJerkMean),gravityMean)"
## [82] "angle(tBodyGyroMean,gravityMean)"    
## [83] "angle(tBodyGyroJerkMean,gravityMean)"
## [84] "angle(X,gravityMean)"                
## [85] "angle(Y,gravityMean)"                
## [86] "angle(Z,gravityMean)"                
## [87] "Activity"                            
## [88] "Subject"

#By examining extractedData, we can say that the following acronyms can be replaced:
  
#  Acc can be replaced with Accelerometer
#  Gyro can be replaced with Gyroscope
#  BodyBody can be replaced with Body
#  Mag can be replaced with Magnitude
#  Character f can be replaced with Frequency
#  Character t can be replaced with Time

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#Here are the names of the variables in extractedData after they are edited
##  [1] "TimeBodyAccelerometerMean()-X"                    
##  [2] "TimeBodyAccelerometerMean()-Y"                    
##  [3] "TimeBodyAccelerometerMean()-Z"                    
##  [4] "TimeBodyAccelerometerSTD()-X"                     
##  [5] "TimeBodyAccelerometerSTD()-Y"                     
##  [6] "TimeBodyAccelerometerSTD()-Z"                     
##  [7] "TimeGravityAccelerometerMean()-X"                 
##  [8] "TimeGravityAccelerometerMean()-Y"                 
##  [9] "TimeGravityAccelerometerMean()-Z"                 
## [10] "TimeGravityAccelerometerSTD()-X"                  
## [11] "TimeGravityAccelerometerSTD()-Y"                  
## [12] "TimeGravityAccelerometerSTD()-Z"                  
## [13] "TimeBodyAccelerometerJerkMean()-X"                
## [14] "TimeBodyAccelerometerJerkMean()-Y"                
## [15] "TimeBodyAccelerometerJerkMean()-Z"                
## [16] "TimeBodyAccelerometerJerkSTD()-X"                 
## [17] "TimeBodyAccelerometerJerkSTD()-Y"                 
## [18] "TimeBodyAccelerometerJerkSTD()-Z"                 
## [19] "TimeBodyGyroscopeMean()-X"                        
## [20] "TimeBodyGyroscopeMean()-Y"                        
## [21] "TimeBodyGyroscopeMean()-Z"                        
## [22] "TimeBodyGyroscopeSTD()-X"                         
## [23] "TimeBodyGyroscopeSTD()-Y"                         
## [24] "TimeBodyGyroscopeSTD()-Z"                         
## [25] "TimeBodyGyroscopeJerkMean()-X"                    
## [26] "TimeBodyGyroscopeJerkMean()-Y"                    
## [27] "TimeBodyGyroscopeJerkMean()-Z"                    
## [28] "TimeBodyGyroscopeJerkSTD()-X"                     
## [29] "TimeBodyGyroscopeJerkSTD()-Y"                     
## [30] "TimeBodyGyroscopeJerkSTD()-Z"                     
## [31] "TimeBodyAccelerometerMagnitudeMean()"             
## [32] "TimeBodyAccelerometerMagnitudeSTD()"              
## [33] "TimeGravityAccelerometerMagnitudeMean()"          
## [34] "TimeGravityAccelerometerMagnitudeSTD()"           
## [35] "TimeBodyAccelerometerJerkMagnitudeMean()"         
## [36] "TimeBodyAccelerometerJerkMagnitudeSTD()"          
## [37] "TimeBodyGyroscopeMagnitudeMean()"                 
## [38] "TimeBodyGyroscopeMagnitudeSTD()"                  
## [39] "TimeBodyGyroscopeJerkMagnitudeMean()"             
## [40] "TimeBodyGyroscopeJerkMagnitudeSTD()"              
## [41] "FrequencyBodyAccelerometerMean()-X"               
## [42] "FrequencyBodyAccelerometerMean()-Y"               
## [43] "FrequencyBodyAccelerometerMean()-Z"               
## [44] "FrequencyBodyAccelerometerSTD()-X"                
## [45] "FrequencyBodyAccelerometerSTD()-Y"                
## [46] "FrequencyBodyAccelerometerSTD()-Z"                
## [47] "FrequencyBodyAccelerometerMeanFreq()-X"           
## [48] "FrequencyBodyAccelerometerMeanFreq()-Y"           
## [49] "FrequencyBodyAccelerometerMeanFreq()-Z"           
## [50] "FrequencyBodyAccelerometerJerkMean()-X"           
## [51] "FrequencyBodyAccelerometerJerkMean()-Y"           
## [52] "FrequencyBodyAccelerometerJerkMean()-Z"           
## [53] "FrequencyBodyAccelerometerJerkSTD()-X"            
## [54] "FrequencyBodyAccelerometerJerkSTD()-Y"            
## [55] "FrequencyBodyAccelerometerJerkSTD()-Z"            
## [56] "FrequencyBodyAccelerometerJerkMeanFreq()-X"       
## [57] "FrequencyBodyAccelerometerJerkMeanFreq()-Y"       
## [58] "FrequencyBodyAccelerometerJerkMeanFreq()-Z"       
## [59] "FrequencyBodyGyroscopeMean()-X"                   
## [60] "FrequencyBodyGyroscopeMean()-Y"                   
## [61] "FrequencyBodyGyroscopeMean()-Z"                   
## [62] "FrequencyBodyGyroscopeSTD()-X"                    
## [63] "FrequencyBodyGyroscopeSTD()-Y"                    
## [64] "FrequencyBodyGyroscopeSTD()-Z"                    
## [65] "FrequencyBodyGyroscopeMeanFreq()-X"               
## [66] "FrequencyBodyGyroscopeMeanFreq()-Y"               
## [67] "FrequencyBodyGyroscopeMeanFreq()-Z"               
## [68] "FrequencyBodyAccelerometerMagnitudeMean()"        
## [69] "FrequencyBodyAccelerometerMagnitudeSTD()"         
## [70] "FrequencyBodyAccelerometerMagnitudeMeanFreq()"    
## [71] "FrequencyBodyAccelerometerJerkMagnitudeMean()"    
## [72] "FrequencyBodyAccelerometerJerkMagnitudeSTD()"     
## [73] "FrequencyBodyAccelerometerJerkMagnitudeMeanFreq()"
## [74] "FrequencyBodyGyroscopeMagnitudeMean()"            
## [75] "FrequencyBodyGyroscopeMagnitudeSTD()"             
## [76] "FrequencyBodyGyroscopeMagnitudeMeanFreq()"        
## [77] "FrequencyBodyGyroscopeJerkMagnitudeMean()"        
## [78] "FrequencyBodyGyroscopeJerkMagnitudeSTD()"         
## [79] "FrequencyBodyGyroscopeJerkMagnitudeMeanFreq()"    
## [80] "Angle(TimeBodyAccelerometerMean,Gravity)"         
## [81] "Angle(TimeBodyAccelerometerJerkMean),GravityMean)"
## [82] "Angle(TimeBodyGyroscopeMean,GravityMean)"         
## [83] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"     
## [84] "Angle(X,GravityMean)"                             
## [85] "Angle(Y,GravityMean)"                             
## [86] "Angle(Z,GravityMean)"                             
## [87] "Activity"                                         
## [88] "Subject"

############
#TASK 5 of 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
############

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#We create tidyData as a data set with average for each activity and subject. Then, we order the enties in tidyData and write it into data file Tidy.txt that contains the processed data

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
