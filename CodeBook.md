CodeBook that describes the variables, the data, and any transformations or work performed to clean up the data 
collected from the accelerometers from the Samsung Galaxy S smartphone.

R code file: run_analysis.R

DATA
-----

The input files data are available in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Used input data files:

From directory "UCI HAR Dataset":
	"features.txt";
	"activity_labels.txt".
	
From directory "train":

	"X_train.txt";
	"y_train.txt";
	"subject_train.txt".

From directory "test":

	"X_test.txt";
	"y_test.txt";
	"subject_test.txt".
 

FUNCTIONS AND VARIABLES
------------------------

getDataSet Function: 
	parameters:
		expFile -> experiment file (X_train or X_test);
		actFile -> activity file (y_train or y_test);
		subFile -> subject file (subject_train or subject_test).
    return:
	     Data frame for "train" or "test";

dfTrain: data frame with train´s data;
dfTest: data frame with test´s data;
dfTrain_Test: data frame resulting of dfTrain and dfTest merging;
dfActLabels: data frame with activities labels;
dfMeanStdFeatures: data frame (wide-format) with the measurements on the mean and standard deviation for each measurement;
dfMeanStdFeaturesTidy: tidy data frame with the measurements on the mean and standard deviation for each measurement;
tblFeaturesMeans: tibble data frame for store dfMeanStdFeaturesTidy group by SubjectNumber anda Activity Description;
dfFeaturesSummary: data set with the average of each variable for each activity and each subject.

TRANFORMATIONS or WORKS
------------------------

1) Merging Data frames  - dfTrain and dfTest ;
2) left join (dfTrain_Test and dfActLabels) to get "Activity Labels" for each "Activity Code" available;
3) Transform data set from wide-format for long-format (tidy) with "melt" - dfMeanStdFeatures for dfMeanStdFeaturesTidy;
4) Group by data set (dfMeanStdFeaturesTidy) by SubjectNumber anda Activity Description;
5) "Summarise" the group above and calculate the mean.


