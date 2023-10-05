#code related to population ecology

# a package is needed for point pattern anlysis
install.packages("spatstat")

library(spatstat)

#let's use tge bei data
#data transcription

bei #this is the dataset

#plotting the data
plot(bei)
#changing dimension

plot(bei, cex=0.5)
#changing the symbol with pch (lo is trova su internet il numero)
plot(bei, cex=0.5, pch=19)

#additional dataset
bei.extra 
#how to select a single part of the dataset
plot(bei.extra)
#let's use only part of the dataset: elev
plot(bei.extra$elev)
elevation<-bei.extra$elev
plot(elevation)
#second metohd to select elements
elevation2<-bei.extra[[1]]
plot(elevation2)
