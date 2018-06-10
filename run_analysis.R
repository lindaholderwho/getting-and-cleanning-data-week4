#¶ÁÈ¡Êý¾Ý
setwd("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\train")
X_train<-read.table("X_train.txt")
y_train<-read.table("Y_train.txt")
subject_train<-read.table("subject_train.txt")

X_test<-read.table("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
subject_test<-read.table("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")

features<-read.table("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
activity_labels<-read.table("C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")

#1.Merges the training and the test sets to create one data set.
X_total<-rbind(X_train,X_test)
y_total<-rbind(y_train,y_test)
sub_total<-rbind(subject_train,subject_test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
selected_var <- features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
X_total <- X_total[,selected_var[,1]]

#3.Uses descriptive activity names to name the activities in the data set
colnames(y_total) <- "activity"
y_total$activitylabel <- factor(y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- y_total[,-1]

#4.Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- features[selected_var[,1],2]

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(sub_total) <- "subject"
total <- cbind(X_total, activitylabel, sub_total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarise_at(funs(mean))
write.table(total_mean, file = "C:\\Users\\linda\\Downloads\\getdata\\projectfiles\\UCI HAR Dataset\\UCI HAR Dataset\\tidydata.txt", row.names = FALSE, col.names = TRUE)







