
# Read in the column labels for the features vectors.
featureLabels = read.table('UCI HAR Dataset\\features.txt', col.names = c('index', 'name'))

# Find the indices that contain variable means and standard deviations.
meanIndices = grep('mean()', featureLabels$name, fixed = T)
stdIndices = grep('std()', featureLabels$name, fixed = T)

# There are 17 measured device outputs, 8 that have (x,y,z) components and 9 that do not. Thus
# we should have 8*3 + 9 = 33 variables on which mean() and std() are computed.
if (length(meanIndices) != 33 || length(stdIndices) != 33)
  stop('data format error in features.txt')

# Read in the vector with 561 features per observation and combine the training and test sets.
observations = rbind(read.table('UCI HAR Dataset\\train\\X_train.txt'),
                 read.table('UCI HAR Dataset\\test\\X_test.txt'))
# Throw away the columns we aren't interested in.
observations = observations[, c(meanIndices, stdIndices)]
# Give the columns descriptive names based on the feature labels we read in earlier.
names(observations) = as.character(featureLabels$name[c(meanIndices, stdIndices)])

# These data files associate each row with the subject the data was taken from. Read them in
# and give the data frame a descriptive name.
subjects = rbind(read.table('UCI HAR Dataset\\train\\subject_train.txt'),
                 read.table('UCI HAR Dataset\\test\\subject_test.txt'))
names(subjects) = 'subjectID'

# These files have the activity associated with each observation vector. Read in and name them.
activity = rbind(read.table('UCI HAR Dataset\\train\\y_train.txt'),
                 read.table('UCI HAR Dataset\\test\\y_test.txt'))
names(activity) = 'activityID'

# To convert the activities from a numeric coding to a more descriptive factor variable, we
# read in the activity labels from a file and use them as factor labels.
activityLabels = read.table('UCI HAR Dataset\\activity_labels.txt',
                            col.names = c('activityID', 'activityLabel'))
activity = factor(activity$activityID, labels = activityLabels$activityLabel)
names(activity) = 'activity'

# Now we combine the data for observations, activity, and subjects into one data frame.
combinedDF = cbind(observations, activity, subjects)

# Finally, we make a second data frame that contains the mean of all 66 observations for each
# activity and subject pair.
averageValues = aggregate(observations, list(subjects$subjectID, activity), mean)
names(averageValues)[1:2] = c('subjectID', 'activity')

# Write the second data frame to an output file.
write.table(averageValues, 'average_vals.txt', row.name=FALSE)

print('Summary dataset was generated and written to average_vals.txt')
