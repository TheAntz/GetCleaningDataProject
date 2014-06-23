Coursera Getting and Cleaning Data Course Project
=================================================

The files and information in the repo has been created as a submission for the course project in Coursera's 'Getting and Cleaning Data' course and is hosted here on Github for peer review. 

As students we were provided with a copy of the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) produced in the study by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto. 

The data set information from the README.txt, in the compressed dataset archive, provides this introdutory description of the source of the data.
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The file 'run_analysis.R' in the root of this repository is a R script which performs the required tasks of merging the sets, reducing the number of features/columns to those that are a calculated mean or standard deviation, applies appropriate labels to the dataset, replaces the integer references for the various activities with the activity names and finally outputs a tidy data set consisting of the average of each variable for each activity performed by each subject. A detailed explanation of how each of these steps was achieved by this script is provided by the following table.

Line(s) | Description of task implimentation in script
-------:|:---------------------------------------------
9 ~ 16  | Check if the initial provided data set archive is present in the current working directory. If not it is then downloaded from the coursera CDN.
17 ~ 23 | Check if the data set has been extracted from the archive into the working and if not then extract the files from the ZIP archive.
25 ~ 43 | Accomplishes project task #1
        | Loads and merges the data set components from the training and testing  portions in the files 'subject_train.txt', 'X_train.txt' and 'y_train.txt'
        | (for the training portion) and 'subject_test.txt', 'X_test.txt' and 'y_test.txt' (for the testing portion). Each is column binded to the accumulating
        | data frame for traing and testing, and these two data frames are then row binded to complete the initial data set.
45 ~ 60 | Accomplishes project task #4
        | Labels the columns in our dataset with descriptive variable names. Variable names are read from the file 'features.txt' and the names of the 
        | first and last columns ("Subject" and "Activity") are appended to the start  and end of the vector of variable names. Any characters in the variable
        | names which may cause syntax error in R are removed from each name and dashes and  commas are replaced by underscores to preserve
        |  readability. To further the descriptive nature of these variable names 't', 'f' and 'anglet' at the start of the variable names are replaced with the 
        | more descriptive 'time_', 'freq_' and 'angle_time_'. The new variable names are then applied to the columns of our data frame.
62 ~ 68 | Accomplishes project task #2
        | A logical vector of the columns containing the variables we wish to have in our final tidy dataset is created by searching the vector of column
        | names for those containing the strings 'Subject', 'Activity', 'mean' or 'std'. The data frame is then subset keeping only the columns/variables as
        | specified by the logical vector 'neededCols'.
70 ~ 76 | Accomplishes project task #3
        | The activity labels and names are read from the file 'activity_labels.txt'  and the values in the 'Activity' column of our dataset are mapped to their
        | corresponding character strings as factors.
78 ~ 85 | Accomplishes project task #5
        | The data frame is melted and then cast into our final tidy data frame containing the average value for each variable for each activity performed
        | by each subject. This final data frame is then written to a file 'tidyData.txt' in the working directory using the write.csv() function and can be 
        | read back into R using the following command (assuming the 'tidyData.txt' file is in the working directory):
        | `read.csv("tidyData.txt")`
87 ~ 90 | Cleans up the environment by removing all vectors and data frames that are no longer needed, and then prints out a final message informing
        | the user of the description of the two data frames data (the initial processed data frame) and tidyData (the final tidy data set).
        

The following R packages are required by the run_analysis.R script:
+ plyr
+ utils
+ reshape2
