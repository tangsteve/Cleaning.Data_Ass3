#prepare for reading files from sub-folder, building path, and name the varible
set <- c("test","train")
xysub <- c("X", "y", "subject")
set[1]
xysub[1]
for (i in 1:2){
    for (j in 1:3){
    url <- paste("./",set[i],"/",xysub[j],"_",set[i],".txt",sep="")
    
    assign(paste(tolower(xysub[j]),"_",set[i],sep=""),read.table(url,header=FALSE,sep=""))
    }}
rm(url)
all_x <- rbind(x_test, x_train)
all_y <- rbind(y_test, y_train)
all_sub <- rbind(subject_test, subject_train)
rm(x_test, x_train, y_test,y_train,subject_test,subject_train)

# Calculate Mean and sd of each variable after merge of variables

allx_mean <- apply(all_x,2,mean)
allx_sd <- apply(all_x, 2, sd)


act_name <- read.table("./activity_labels.txt")

### extract names and put them in dataframe
names_Y <- factor(all_y$V1,labels = as.vector(act_name$V2))
y.name <- as.vector(act_name$V2)
all_y_with_names <- data.frame(names_Y)
rm(act_name)
###
names_561 <- read.table("./features.txt")
x2_all <- all_x
var.name <- as.vector(names_561$V2)
rm(names_Y, names_561)
colnames(x2_all) <- var.name
colnames(all_sub) <- c("Subject")
colnames(all_y_with_names) <- c("Act")
#answer of step 4 after putting the column name
df <- cbind(all_sub,all_y_with_names,x2_all)

#each of Step 5
df_0 <- data.frame()

for (i in 1:30){
    df_p <- df[df$Subject==i,]
    for (j in 1:6){
        df_sum <- 0
        df_q <- df_p[df_p$Act == y.name[j],]
    df_sum <- apply(df_q[,3:563], 2, mean)
    df_0 <- rbind(df_0,df_sum)
    }
}
rm(df_p,df_q,df_sum)


test <- rep(c(1:30), each = 6)
test2 <- rep(y.name, length.out = 180)
df_q5 = cbind(test, test2, df_0)
rm(df_0,test,test2)
colnames(df_q5) = c("Subject", "Act",var.name)
write.table(df_q5,"./summary.txt",row.name=FALSE)
