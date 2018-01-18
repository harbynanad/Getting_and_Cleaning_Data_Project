## Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Load activity labels + features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# Load the datasets
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
train_activities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
test_activities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge datasets and add labels
all_data <- rbind(train, test)
colnames(all_data) <- c("subject", "activity", featuresWanted.names)

# turn activities & subjects into factors
all_data$activity <- factor(all_data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
all_data$subject <- as.factor(all_data$subject)

all_data.melted <- melt(all_data, id = c("subject", "activity"))
all_data.mean <- dcast(all_data.melted, subject + activity ~ variable, mean)

# second tidy data set
write.table(all_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
