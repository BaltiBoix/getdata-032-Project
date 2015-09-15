run_analysis<-function(){
      
      ## Read the table that links the activity index with the activity name.
      ##
      activity_labels<-read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
      
      ## Read the table that links the feature index with the feature name.
      ##
      features<-read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
      
      ## Read and merge the training and the test sets to create one data set.
      ##
      subject<-rbind(read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE),
                     read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE))
      
      y<-rbind(read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE),
               read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE))

      x<-rbind(read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE),
               read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE))
      
      ## Rename the columns with the features names.
      ##
      names(x)<-features$V2
      
      ## Select the columns with "-mean()" and "-std()" in their name.
      ##
      selNames<-sort(rbind(grep("-mean()",names(x), fixed=TRUE), grep("-std()",names(x), fixed=TRUE)))
      x<-x[,selNames]
      
      ## Add two columns with the activity name and subject number.
      ##
      x$activity<-activity_labels$V2[y$V1]
      x$subject<-subject$V1
      
      ## write data.frame x into file xtidy.txt 
      ##
      write.table(x, file="xtidy.txt",row.names = FALSE)
      
      ## Perform the calculation of the average of each variable(feature) for each activity and each subject
      ##
      xmean<-aggregate(x[,1:66], list(activity=x$activity, subject=x$subject), mean)
      activity_labels$V2[as.numeric(xmean$activity)]
      
      ## write data.frame xmean into file xmean.txt 
      ##
      write.table(xmean,file="xmean.txt",row.names = FALSE)
      
}