# UCI HAR Summary Statistics Project CodeBook

## Output Data Format

The output dataset is contained in the file average_vals.txt and is stored in a format that is easily readable by R's read.table() function. The dataset has the following columns:

* SubjectID: Numeric identifier of which subject generated the observations in the row. There were 30 subjects for this experiment, numbered 1-30.

* Activity: Description of the activity the subject performed while the smartphone data was sampled. The activities are one of the following: (WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING).

* Columns 3-68: Average values of numeric readouts from the smartphone's motion sensors that correspond to the subject and activity in that row. The names are taken from the dataset on the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) study website so that the fields can be easily cross referenced to the original dataset. Note that the summary dataset referenced in this codebook contains averages of these data points, even though the field names are unchanged.

The features in columns 3-68 were selected from the larger set of 561 columns in the original dataset because these features represent means or standard deviations of smartphone device data. Selecting only these features and no others was explicitly specified by the assignment instructions.

For detailed information on the features in the original dataset, please refer to features_info.txt contained in the original dataset zip file. The features from that dataset that we used are the mean and standard deviation of the following device outputs:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Note that there are 17 measured device outputs, 8 that have (x,y,z) components and 9 that do not. Thus we should have 8*3 + 9 = 33 variables in our summary data set on which we compute mean() and std(), giving a total of 66 fields.