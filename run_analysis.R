# project course Getting and cleaning data
# tasks:

# 1) Merges the training and the test sets to create one data set;
# 2) Extracts only the measurements on the mean and standard deviation for each measurement;
# 3) Uses descriptive activity names to name the activities in the data set;
# 4) Appropriately labels the data set with descriptive variable names;
# 5) From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.

library(dplyr)
library(reshape2)

#set work directory
sWorkDir <- ".\\UCI HAR Dataset\\"
features <- "features.txt"
ACTLABELS <- "activity_labels.txt"
# >>>> parameters for train:

expTrain <- "train\\X_train.txt"
actTrain <- "train\\y_train.txt"
subTrain <- "train\\subject_train.txt"

# >>>> parameters for test:

expTest <- "test\\X_test.txt"
actTest <- "test\\y_test.txt"
subTest <- "test\\subject_test.txt"


#expFile -> experiments files
#actFile -> activities files
#subFile -> subjects files

getDataSet <- function (expFile, actFile, subFile) {
  #reading traning/test experiments 
  dfTemp <- read.delim2(paste(sWorkDir,expFile,sep = ""), header = FALSE, sep = "")
  #elements conversion factor -> numeric
  dfTemp <- as.data.frame(apply(dfTemp, 2,function(x) as.numeric(as.character(x))))
  
  
  #reading the features - it are used for columns names of dfTrain and dfTest data frames
  
  dfFeatures <- read.delim2(paste(sWorkDir,features,sep = ""), header = FALSE, sep = "")
  dfFeatures <- mutate(dfFeatures, V3 = paste(V1,V2,sep = "-"))
  colnames(dfTemp) <- as.character(dfFeatures$V3)
  
  
  #creating activity column
  
  #read y-train to get activity description
  dfCodeLabelsActivities <- read.delim2(paste(sWorkDir,actFile,sep = ""), header = FALSE, sep = "")
  vCodeLabelsActivities <- as.numeric(dfCodeLabelsActivities$V1)
  
  #create new column for activity code
  dfTemp$ActivityCode <- vCodeLabelsActivities
  
  #creating subject column
  #read subject number
  dfSubjectNumber <- read.delim2(paste(sWorkDir,subFile,sep = ""), header = FALSE, sep = "")
  vSubjectNumber <- as.numeric(dfSubjectNumber$V1)
  
  #create new column into dfTrain for subject number
  dfTemp$SubjectNumber <- vSubjectNumber
  
  #return data frame
  dfTemp
  
}


dfTrain <- getDataSet (expTrain, actTrain, subTrain)
dfTest <- getDataSet(expTest, actTest, subTest)

#Data frames Merging

dfTrain_Test <- rbind.data.frame(dfTrain, dfTest)

dfActLabels <- read.delim2(paste(sWorkDir,ACTLABELS,sep = ""), header = FALSE, sep = "")
colnames(dfActLabels) <- c("ActivityCode", "ActivityDescription")


dfTrain_Test <- left_join(dfTrain_Test, dfActLabels, by=c("ActivityCode"))


#Extracts only the measurements on the mean and standard deviation for each measurement

dfMeanStdFeatures <- select(dfTrain_Test, contains("std"), contains("mean"), ActivityCode, SubjectNumber, ActivityDescription)

#transform data set from wide-format for long-format (tidy) with "melt"
dfMeanStdFeaturesTidy <- melt(dfMeanStdFeatures, id.vars = c("ActivityCode", "SubjectNumber","ActivityDescription"),
                              variable.name = "Features", 
                              value.name = "Measure")
#Select only necessary columns   
dfMeanStdFeaturesTidy <- select(dfMeanStdFeaturesTidy, SubjectNumber, ActivityDescription, Features, Measure )

#group by data set by SubjectNumber anda Activity Description
tblFeaturesMeans <- dfMeanStdFeaturesTidy %>% group_by(SubjectNumber, ActivityDescription)

#data set with the average
#    of each variable for each activity and each subject.
dfFeaturesSummary <- summarise(tblFeaturesMeans, Mean = mean(Measure))

#writing output file with data set 
write.table(dfFeaturesSummary, file = "FeaturesSummary.txt", row.names = FALSE)
