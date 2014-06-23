Coursera Getting and Cleaning Data Project - Tidy Data Set Code Book
====================================================================
This tidy data set consists of 180 observations of 88 variables. These represent the average of the measured mean and standard deviation values, of each variable record in the original data set, for each of the activities performed by the studies subjects.
    
  
**The columns in the data set represent the following information in the stated representation:**

**Subject**

An integer value denoting one of the subjects in the study. 

**Activity**

A factor variable denoting the activity which was performed.

**Variables in remaining columns**

Computed average values for each of the variables in the original data set that were a calculated mean or standard deviation of a measured input. These are selected from the original data set by the condition that the string "mean" or "std" appeared in the variable name. Any characters in the remaining variable names likely to cause syntax errors in R (parenthesis and addition signs) were then removed and any dashes or commas in the names were replaced with underscores to preserve readability.

Further details on the variable names can be found in the 'features_info.txt' file contained in the original data set ZIP archive (available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

While the Subject and Activity variables in this data set refer to the studies subjects and performed activities as discrete items, the remainder of the variables are computed from values in the orginal data set that were normalised and bounded withing [-1,1] and as a result have no measurement units associated with them.