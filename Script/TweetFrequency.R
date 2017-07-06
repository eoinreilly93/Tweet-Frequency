#################################
# DATA PREPARATION
#################################

#READ IN THE DATA IF IT IS STORED ON YOUR LOCAL MACHINE
tweetsdf <- read.csv("Resources/Datasets/DonaldTrumpTweets18_03_17.csv", header = T, sep = ",")

#FORMAT FEATURES 
Time <- format(as.POSIXct(strptime(tweetsdf$created,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%H:%M:%S")
Date <- format(as.POSIXct(strptime(tweetsdf$created,"%Y-%m-%d %H:%M:%S",tz="")) ,format = "%Y-%m-%d")

tweetsdf$TweetDate <- as.POSIXct(Date)
tweetsdf$TweetTime <- as.POSIXct(Time, format = "%H:%M:%S")

##############################
# ANALYSIS
###############################

#REFINE DATA TO ONLY NECESSARY COLUMNS
refinedDF <- tweetsdf[c(5,20,21)]

#SUBSET BY DATE IF YOU WISH
JanTweets <- subset(refinedDF, refinedDF$TweetDate >= "2017-01-01" & refinedDF$TweetDate <= "2017-01-31")

#LIMITS TO TRY AND SCALE THE Y-AXIS TO START AT 00:00 AND END AT 00:00
#DOES NOT WORK ATM
lims <- as.POSIXct(strptime(c("2017-02-03 00:00","2017-02-03 23:59"), 
                            format = "%Y-%m-%d %H:%M:%S")) 

#PLOT USING gglot2
library(ggplot2)
library(scales)
ggplot(refinedDF, aes(x=TweetDate, y=TweetTime)) + 
  geom_point(aes(colour = I("blue"))) + 
  scale_y_datetime(limits = lims, breaks = date_breaks("3 hour"), minor_breaks=date_breaks("30 min"), labels=date_format("%H:%M")) + 
  scale_x_datetime(breaks = date_breaks("2 month")) +
  theme(axis.text.x=element_text(angle=360)) +
  theme(plot.title = element_text(family = "Trebuchet MS", color="#000000", face="bold", size=18, hjust=0.5)) +
  theme(axis.title = element_text(family = "Trebuchet MS", color="#302e2e", face="bold", size=12)) + 
  ggtitle("Tweet Frequency Over Time") +
  labs(x="Tweet Date",y="Tweet Time")


