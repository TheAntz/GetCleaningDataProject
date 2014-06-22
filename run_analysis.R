## run_analysis.R
## This R script completes the task of compiling a tidy data set as required for
## the course assigment for Coursera's "Getting and Cleaning Data" course.
## More information can be found in the Readme.MD file in the same repository as
## this file.
##
## 
###
# Check if we already have the archive of the original dataset in the current
# working directory.
if(!file.exists("./UCI HAR Dataset.zip")) {
  # We don't have the archive, so download it to our working directory
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  message("Downloading project dataset archive...")
  download.file(fileURL, destfile="./UCI HAR Dataset.zip")  
}
# Ensure that the project data has been extracted from the downloaded archive file
if(!file.exists("./UCI HAR Dataset/README.txt")) {
  # Extract the dataset from the archive into the working directory
  library(utils)
  message("Extracting dataset from ZIP archive to working directory...")
  unzip("./UCI HAR Dataset.zip")
}

## Start of project task #1 - Merge training and test data into a single data set.
#
# Load dataset components from the various files
# Load and combine training data
message("Reading file: subject_train.txt ...")
data <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("Subject"), colClasses="factor")
message("Reading file: X_train.txt ...")
data <- cbind(data, read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE))
message("Reading file: y_train.txt ...")
data <- cbind(data, read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("Activity"), colClasses="factor"))
# Load and combine testing data
message("Reading file: subject_test.txt ...")
testdata <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("Subject"), colClasses="factor")
message("Reading file: X_test.txt ...")
testdata <- cbind(testdata, read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE))
message("Reading file: y_test.txt ...")
testdata <- cbind(testdata, read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("Activity"), colClasses="factor"))
# Combine training and testing data
data <- rbind(data, testdata)

## Start of project task #4 - Label the data set with descriptive variable names
message("Reading variable names from file: features.txt ...")
varnames <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses=c("integer","character"))
varnames <- varnames[,2]
varnames <- c("Subject", varnames, "Activity")
# Remove special characters from names
message("Removing special characters from names...")
varnames <- gsub("[\\(\\)+]", "", varnames)
varnames <- gsub("[-,]", "_", varnames)
message("Modifying names to be more descriptive...")
varnames <- gsub("^t", "time_", varnames)
varnames <- gsub("^f", "freq_", varnames)
varnames <- gsub("^anglet", "angle_time_", varnames)
message("Applying new descriptive variable names to data frame...")
names(data) <- varnames

## Start of project task #2 - Reducing columns to only those containing a calculated
## mean or standard deviation of a measurement
message("Reducing dataset to include only calculated means or Std deviations of measured variables...")
# Get logical vector of which columns to keep
neededCols <- grepl("Subject|Activity|mean|std", names(data), ignore.case=TRUE)
neededCols <- neededCols & (!grepl("meanFreq", names(data), ignore.case=TRUE))
# Subset data frame to only the required columns
data <- data[,neededCols]

## Start of project task #3 - Convert activity integer labels to useful named factors
# Load activity labels
message("Reading file: activity_labels.txt ...")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses=c("factor","character"))
message("Mapping integer Activity factor values to descriptive string factors...")
library(plyr)
data$Activity <- as.factor(mapvalues(data$Activity, from=activities[,1], to=activities[,2]))

## Start of project task #5 - Create a tidy data set with the average of each variable for each activity and each subject
# ...






# Cleanup temporary environment variables
remove(testdata, varnames, neededCols, activities)

message("Script execution complete.")