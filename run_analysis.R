#LOAD LIBRARIES NEEDED
library(dplyr)

#ROW BIND THE TRAIN AND TEST DATA, COLUMN BIND THE 3 SETS TO MAKE A FINAL DATASET
x_comb <- rbind(x_train, x_test)
y_comb <- rbind(y_train, y_test)
subject_comb <- rbind(subject_train, subject_test)
all_data <- cbind(subject_comb, x_comb, y_comb)
#dim(all_data) 

#EXTRACT THE SUBJECT, ACTIVITY CODE, MEAN & STD DEV FOR EACH MEASUREMENT
neat_data <- all_data %>% select(subject, shorthand, contains("mean"), 
                                 contains("std"))

#head(neat_data) 
#dim(neat_data) 

#USE DESCRIPTIVE ACTIVITY NAMES FOR ACTIVITIES
neat_data$shorthand <- activities[neat_data$shorthand, 2]
#head(neat_data)


#USE DESCRIPTIVE VARIABLE NAMES
names(neat_data)[1] = "Subject"
names(neat_data)[2] = "Activity"
names(neat_data) <- gsub("Acc", "Accelerometer", names(neat_data))
names(neat_data) <- gsub("Gyro", "Gyroscope", names(neat_data))
names(neat_data) <- gsub("Mag", "Magnitude", names(neat_data))
names(neat_data) <- gsub("tGravity", "TimeGravity", names(neat_data))
names(neat_data) <- gsub("freq", "Frequency", names(neat_data), 
                         ignore.case = TRUE)
names(neat_data) <- gsub("tBody", "TimeBody", names(neat_data))
names(neat_data) <- gsub("mean", "Mean", names(neat_data), 
                         ignore.case = TRUE)
names(neat_data) <- gsub("std", "STD", names(neat_data), 
                         ignore.case = TRUE)
names(neat_data) <- gsub("f", "Frequency", names(neat_data))
names(neat_data) <- gsub("angle", "Angle", names(neat_data))
names(neat_data) <- gsub("gravity", "Gravity", names(neat_data))

#FOR ME - TEST OUTPUT OF DATA AS A TIDY SHEET
#write.csv(neat_data[1:100, ], "Test.csv", row.names = F)

#USE TIDY OUTPUT TO FIND THE AVERAGE FOR EACH VARIABLE FOR EACH SUBJECT 
# & EACH ACTIVITY & OUTPUT FILE AS .TXT
final_neat_data <- neat_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

write.table(final_neat_data, "My_Neat_Data.txt",  row.names = F)