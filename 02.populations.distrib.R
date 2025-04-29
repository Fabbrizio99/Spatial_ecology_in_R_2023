# why does the population disperse over the landscape in a certain manner?

library(sdm)
library(terra)

file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)

rana$Occurrence # this gives us the ‘presence absence data’ to understand whether or not there are specimens in certain positions
#we graph the positions of the frog vector, i.e. presence and absence 
plot(rana)
#we must only choose where there is presence or absence

# selecting presences
pres <- rana[rana$Occurrence==1,] #per chiudere si usa la virgola, 

# exercise: select absences and call them abse
abse <- rana[rana$Occurrence==0,]
plot(abse)
# exercise: plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(pres, cex=0.5)
plot(abse, cex=0.5)

# exercise: plot pre and abse alltogether with two different colours
# first it is better to close the graphs with the dev.off() function
par(mfrow=c(1,2))
plot(pres, cex=0.5, col="blue")
plot(abse, cex=0.5, col="dark green")
# this way you do it in two different graphs whereas to do it in the same graph you use:
plot(pres, col="dark blue")
points(abse, col="light blue")

# predictors: environmental variables
elev <- system.file("external/elevation.asc", package="sdm") #questa volta non stiamo importando dati ma immagini, cioè rasters
elevmap <- rast(elev) #from terra package
elevmap
plot(elevmap)
points(pres, cex=.5)

#temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <- rast(temp) #from terra package
tempmap
plot(tempmap)
points(pres, cex=.5)

#exercise: do the same with the vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm") 
vegemap <- rast(vege) #from terra package
vegemap
plot(vegemap)
points(pres, cex=.5)

prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) #from terra package
precmap
plot(precmap)
points(pres, cex=.5)

#exercise: multiframe everything together

par(mfrow=c(2,2))

#elev
plot(elevmap)
points(pres, cex=.5)

#temp
plot(tempmap)
points(pres, cex=.5)

#vege
plot(vegemap)
points(pres, cex=.5)

#prec
plot(precmap)
points(pres, cex=.5)
