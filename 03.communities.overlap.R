# relation among species in time 
# we use kernell density since we want to represent the density of the animal in time 

install.packages("overlap")
library(overlap)

data(kerinci) #dataset fo Kerinci National park in Sumatra
head(kerinci) #to see the first 6 rows of the dataset
summary(kerinci) #to see a summary about the variables time, species and zone

# we create a new dataset selecting informations only about thee tiger 
tiger <- kerinci[kerinci$Sps == "tiger",]

# transformation in radiant 
kerinci$timeRad <- kerinci$Time * 2 + pi

# to extract only temporal values of the tiger
timetig <- tiger$timeRad
# then we plot these values with the densityPlot function, here we can see peaks of the tiger during the day
densityPlot(timetig, rug=TRUE)

# ex: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)
timemac <- macaque$timeRad 
densityPlot(timemac, rug=TRUE) # time distribution of the macaque during the day

#to compare the two plots
par(mfrow=c(1,2))
densityPlot(tigertime, rug=TRUE)
densityPlot(macaquetime, rug=TRUE)

#by plotting them overlapped we can see when they will be at the same time in the same place
#we will use the function "overlapPlot"
overlapPlot(timetig, timemac)

