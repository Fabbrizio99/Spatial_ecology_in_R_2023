# Code related to population ecology

# A package is needed for point pattern analysis, we need packages from CRAN (comprehensive R archive network)
install.packages("spatstat")
library(spatstat)

# let's use the bei data inside spatstat:
# data description in the CRAN website:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data
plot(bei)
# points are representing trees monitored in Amazzonia
# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# additional datasets to see a raster (image file)
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
# we can select it with the symbol $
plot(bei.extra$elev)
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements, by data filtering
elevation2 <- bei.extra[[1]]
plot(elevation2)

# passing from points to a countinuous surface
# so we can consider each group of dots as a single unit, and here each unit is going to be dense in according
# to the number of dots in that area
# here we create the density function and rename it 
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2)

#to change the color of the map we can use the function colorRampPalette, 100 is the gradient
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl)

cl2 <- colorRampPalette(c("black", "red", "orange", "yellow"))(4) #if i put gradient equal to 4 colors are less blurred
plot(densitymap, col=cl)

clnew <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(densitymap, col=clnew)
#to add another variable, using the bei.extra dataset 
plot(bei.extra)

elev <- bei.extra[[1]] #or bei.extra$elev, to add the elevation to the gradient
plot(elev)

# multiframe, to plot more things together
# inside the array we need to state how many rows and columns we want to plot and concatenate them 
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)

par(mfrow=c(2,1))
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)
