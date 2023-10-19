# relation among species in time 

install.packages("overlap")
library(overlap)

data(kerinci)

tiger <- kerinci[kerinci$Sps == "tiger",]

kerinci$timeRad<-kerinci$Time * 2 + pi

timetig <- tiger$timeRad
densityPlot(timetig, rug=TRUE)

overlapPlot(timetig, timecac)
