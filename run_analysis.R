#run_analysis.R script
#This script will perform all five steps listed in the instruction page,
#which is also detailed in README.md

#Download and unzip the file from the instruction page to get 
#UCI HAR Dataset

#set working directory to the unzipped UCI HAR Dataset folder
setwd("/Users/lloyd/Documents/lloyd_2016/coursera/DataScience/Course3_Getting_CleaningData/assignment/UCI\ HAR\ Dataset")

#Step 1
#Process test related files
subject_test <- read.csv("./test/subject_test.txt",header = FALSE)
names(subject_test) <- "subject_id"
y_test <- read.csv("./test/y_test.txt", header = FALSE)
names(y_test) <- "activity"
X_test <- readLines("./test/X_test.txt")
X_test1 <- sub("^\\s+","",X_test)
X_test1 <- strsplit(X_test1,"\\s+")
X_test1.df <- data.frame(matrix(unlist(X_test1),nrow = length(X_test1),byrow = T))

feature <- read.table("features.txt",sep = " ")
names(X_test1.df) <- feature$V2
record <- 1:2947
test.df <- cbind(record,subject_test,y_test, X_test1.df)

#Process train related files
subject_train <- read.csv("./train/subject_train.txt",header = FALSE)
names(subject_train) <- "subject_id"
y_train <- read.csv("./train/y_train.txt", header = FALSE)
names(y_train) <- "activity"
X_train <- readLines("./train/X_train.txt")
X_train1 <- sub("^\\s+","",X_train)
X_train1 <- strsplit(X_train1,"\\s+")
X_train1.df <- data.frame(matrix(unlist(X_train1),nrow = length(X_train1),byrow = T))

feature <- read.table("features.txt",sep = " ")
names(X_train1.df) <- feature$V2
record <- 2948:10299
train.df <- cbind(record,subject_train,y_train, X_train1.df)

#Merge test.df and train.df. This is the answer for step 1.
#Note that it is unclear from the instructions whether files from 
#Inertial Signals folder need to be used but they are ignored here.
merged <- rbind(test.df,train.df)

#Step 2
#Extracts only the measurements on the mean and 
#standard deviation for each measurement.
selec <- grepl("mean|std",names(merged))
merged.mean.std <- merged[,selec]
record_id_activity <- merged[,1:3]
merged.mean.std <- cbind(record_id_activity,merged.mean.std)

#Step 3 for describing activities according to activity_labels.txt
merged.mean.std$activity[merged.mean.std$activity == 1] <- "WALKING"
merged.mean.std$activity[merged.mean.std$activity == 2] <- "WALKING_UPSTAIRS"
merged.mean.std$activity[merged.mean.std$activity == 3] <- "WALKING_DOWNSTAIRS"
merged.mean.std$activity[merged.mean.std$activity == 4] <- "SITTING"
merged.mean.std$activity[merged.mean.std$activity == 5] <- "STANDING"
merged.mean.std$activity[merged.mean.std$activity == 6] <- "LAYING"

#Step 4. The variable names are already done in the above code
#at various places where names() function was used.
#Use View() to check that it has good variable names.
View(merged.mean.std)

#Step 5
library(dplyr)
indexf <- sapply(merged.mean.std,is.factor)
merged.mean.std[indexf] <- lapply(merged.mean.std[indexf],
                                  function(x) as.numeric(as.character(x)))
data.df <- tbl_df(merged.mean.std)

#group by subject_id & activity
data.df <- group_by(data.df,subject_id,activity)

#renaming variables in feature.txt for easier selection
names(data.df) <- gsub("-","",names(data.df))
names(data.df) <- gsub("\\(","",names(data.df))
names(data.df) <- gsub("\\)","",names(data.df))

#summarise average of each variable for each activity, minus record column
tidy.df <- data.df %>% select(subject_id:fBodyBodyGyroJerkMagmeanFreq) %>% 
  summarise_each(funs(mean))

#For submission of answer
write.table(tidy.df,file = "AnsStep5.txt",row.names = FALSE)
