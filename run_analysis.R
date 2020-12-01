Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, destfile = "Dataset.zip")
unzip("./Dataset.zip")

##Train dataset
{
train <- read.table("./UCI HAR Dataset/train/X_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("N", "Feature"))
colnames(train) <- features$Feature

train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_lab <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
train <- cbind(train_subject, train_lab, train)

#train$dataset <- "train"
#train <- train[,c(563,1:562)]
}

##Test dataset
{
test <- read.table("./UCI HAR Dataset/test/X_test.txt")

colnames(test) <- features$Feature

test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_lab <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
test <- cbind(test_subject, test_lab, test)

remove(features, test_lab, train_lab, test_subject, train_subject)

#test$dataset <- "test"
#test <- test[,c(563,1:562)]
}


##Merge
{
Merged <- rbind(test, train); remove(test, train)


activity_lab <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("indices", "names"))

for (i in 1:6) {
        Merged$activity <- gsub(activity_lab$indices[i], activity_lab$names[i], Merged$activity)
}

remove(i, activity_lab)
}

##Extract and final tidy dataset
{
Extracted <- Merged[,c(1, 2, grep("mean()|std()", names(Merged)))]; Extracted <- Extracted[,grep("meanFreq()", names(Extracted), invert = TRUE)]

library(dplyr)
Extracted <- mutate(Extracted, subject.activity = interaction(Extracted$subject, Extracted$activity))

fintable <- as.data.frame(tapply(Extracted[,3], Extracted$subject.activity, mean), col.names = Extracted[3])
colnames(fintable) <- colnames(Extracted[3])
for (i in 4:68) {
        table <- as.data.frame(tapply(Extracted[,i], Extracted$subject.activity, mean))
        colnames(table) <- colnames(Extracted[i])
        fintable <- cbind(fintable, table)
}

write.table(fintable, file = "tidy_dataset.txt")
}



remove(data, i)

