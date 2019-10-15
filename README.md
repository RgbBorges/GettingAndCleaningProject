# Getting And Cleaning Data Course Project
The project objective was analyse data collected from the accelerometers from the Samsung Galaxy S smartphone.

These data was aquired from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The following files were used in this project:

1) Input files:

1.1) From directory "UCI HAR Dataset":

	"features.txt";
	   
	"activity_labels.txt".
	   
	
1.2) From directory "train":

   	"X_train.txt";
	
	"y_train.txt";
	
	"subject_train.txt".
	  
    
1.3) From directory "test":

  	"X_test.txt";
	
	"y_test.txt";
	
	"subject_test.txt".
	  

2) Script File: 

         run_analysis.R;
	 Before execute these script, the following variables must be setted :

		#work directory
          	sWorkDir <- ".\\UCI HAR Dataset\\"

		# train directory
		expTrain <- "train\\X_train.txt"
		actTrain <- "train\\y_train.txt"
		subTrain <- "train\\subject_train.txt"

		# test directory:
		expTest <- "test\\X_test.txt"
		actTest <- "test\\y_test.txt"
		subTest <- "test\\subject_test.txt"

3) Output file:

         FeaturesSummary.txt.



