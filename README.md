Getting-and-Cleaning-Data-Course-Project
========================================

The Script is consists on the following 7 functions;

1.	Run_Analysis(): this main function just calls for the others. It has no inputs and gives the tidy data set required as output. 
2.	descarga_zip(): this function download the data; creates as directory and unzip the data. 
3.	merge (): this function merges the training and the test sets to create one data set. It has no inputs and reproduces a merged data set as output. 
4.	mean_std(): this function extracts only the measurements on the mean and standard deviation for each measurement. It has no inputs and gives the referred output. 
5.	act_names(): uses descriptive activity names to name the activities in the data set. It has no inputs and gives the referred output.  
6.	descriptive_vars(): appropriately labels the data set with descriptive variable names. It has no inputs and gives the referred output.   
7.	tidy_data(): creates a second, independent tidy data set with the average of each variable for each activity and each subject. It has no inputs and gives the referred output.  
