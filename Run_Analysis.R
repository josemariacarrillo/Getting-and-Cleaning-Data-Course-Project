run_analysis<-function(){
        
        ## Main Function
        ## The Tidy data as required in step 5 is created along the following scripts
        ## All of them are defined bellow 
                descarga_zip()
                mydata<-merge()
                mydata<-mean_std(mydata)
                mydata<-act_names(mydata)
                mydata<-descriptive_vars(mydata)
                mydata<-tidy_data(mydata)
        
        return(mydata)
}

descarga_zip <- function (input){ 
        
        #if it doesnt exists, it is created a directory named "data"        
        
        if(!file.exists("./data")){dir.create("./data")}
        
        fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        
        #if it doesnt exists the "zip", it is proceeded with the download to a zip call "data.zip"
        
        if(!file.exists("./data/data2.zip")){download.file(fileUrl,destfile="./data/data2.zip")}
        
        #the file is unzipped
        
        unzip("./data/data2.zip",exdir="./data")
        
}

merge<-function(){
        
        # set variable location of files directory
        
        root_dir<-c("./data/UCI HAR Dataset/")
        
        # read test variables
        
        subject_test<-read.table(paste(root_dir,"/test/subject_test.txt",sep=""),header=FALSE)
        X_test<-read.table(paste(root_dir,"/test/X_test.txt",sep=""),header=FALSE)
        Y_test<-read.table(paste(root_dir,"/test/Y_test.txt",sep=""),header=FALSE)
        
        
        # read train variables
        
        subject_train<-read.table(paste(root_dir,"/train/subject_train.txt",sep=""),header=FALSE)
        X_train<-read.table(paste(root_dir,"/train/X_train.txt",sep=""),header=FALSE)
        Y_train<-read.table(paste(root_dir,"/train/Y_train.txt",sep=""),header=FALSE)
        
        # binds Test labels with Test set
        
        test<-cbind(subject_test,Y_test,X_test)
        train<-cbind(subject_train,Y_train,X_train)
        merge_data<-rbind(train,test)
        
        return (merge_data)  
}

mean_std<-function(input){
        
        root_dir<-c("./data/UCI HAR Dataset/")
        
        # read labels
        
        actlabels<-read.table(paste(root_dir,"activity_labels.txt",sep=""),header=FALSE)
        features<-read.table(paste(root_dir,"features.txt",sep=""),header=FALSE)
        
        # binds Test labels with Test set
        
        features_meanStd<-features[grep("mean()|std()",features[,2]),]
        
        features_mean_cor<-features_meanStd$V1+2
        
        mydata_meanStd<-input[,features_mean_cor]
        
        mydata_meanStd<-cbind(input[,1:2],mydata_meanStd)
        
        return (mydata_meanStd)  
}

act_names<-function(input){
        
        mydata<-input
        
        mydata$act_names<-ifelse(mydata[,2]==1,"WALKING",ifelse(mydata[,2]==2,"WALKING_UPSTAIRS",ifelse(mydata[,2]==3,"WALKING_DOWNSTAIRS",ifelse(mydata[,2]==4,"SITTING",ifelse(mydata[,2]==5,"STANDING","LAYING")))))
        
        # re order columns
        mydata<-mydata[,c(1,2,82,3:81)]
        
        return(mydata)
}

descriptive_vars <-function(input){
        
        mydata<-input
        
        colnames(mydata)[1]<-"subject"
        colnames(mydata)[2]<-"act_names_num"
        
        root_dir<-c("./data/UCI HAR Dataset/")
        features<-read.table(paste(root_dir,"features.txt",sep=""),header=FALSE)
        features_meanStd<-features[grep("mean()|std()",features[,2]),]
        
        colnames(mydata)[4:82]<-as.character(features_meanStd$V2)
        
        return(mydata)
}

tidy_data<-function(input){
        
        library(plyr)
        library(reshape2)
        
        melted <- melt(input, id.vars = c("subject","act_names_num","act_names"),measure.vars=names(u[,4:82]))
        tidy <- ddply(melted,c("subject","act_names_num","act_names"), summarise, mean = mean(value))
        
        return(tidy)
        
}