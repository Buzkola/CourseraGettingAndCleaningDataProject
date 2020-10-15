
Disclaimer: English is not my first language so I apologize for any typing mistake and appreciate any constructive comment.

Assign the different txt files to a respective variable, with the read.table function. 
The (col.names) argument serves for saving time in the future assigning the different col names, doing the work directly at the beggining


1. Merges the training and the test sets to create one data set.
The different sets are binded by their columns creating the new sets based on the 
Train or Test attribute
Finalle both are merged through their rows creating M_dat.

2. Extracts only the measurements on the mean and standard deviation for each measurement
Ext_data comes from the extraction of the measurements(columns) that include the mean or standard deviation

3. Uses descriptive activity names to name the activities in the data set
Replacing the Ext_data code column numbers with their respective value given by the activities file

4. Appropriately labels the data set with descriptive variable names
Renamed code column name to Activity

Replaced most abbreviated columns into their full name, while also changing the function name columns into the respective name.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

IndData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export IndData into IndData.txt file.

A new txt file named IndData.txt is born from the grouping by the different subjects and activities, given from their respective mean. 