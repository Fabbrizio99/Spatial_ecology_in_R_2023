#the higher the variabilit, the higher the nubmber of species
#measurement from RS based variability

library(imageRy)
library(terra)
library(viridis)

#make a list of all the files that are available 
im.list()

sent <- im.import("sentinel.png")
#first band is the NIR
#second band is red
#third band is green
im.plotRGB(sent, r=1, g=2, b=3) #vegetation is red here, since the NIR is in the first layer
#change the visualization
im.plotRGB(sent, r=2, g=1, b=3) #vegetation is green since NIR is in the second band 

nir <- sent [[1]]
plot(nir) #green part is vegetatio, orange is bare soil, 


#moving window--> it calculates the standard deviations of the centrale pixel from a nine selection(3x3) and it is moving until it measure the whole picture, it puts the value in the
#central pixel each time 
#focal, we use the band nir, matrix is describing the dimension of the moving window that here is a 3x3, we descfribe the function we want to use
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)
# we are changing  colors, and the legend with the package viridis (255 is the umbeer of colors that are in the package viridis)
viridisc<-colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
#the area in which there is more variability is north-west
#calculate the variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)

plot(sd7, col=viridisc)
#if you enlarge the moving window we can see a higher variability because we include additional pixels


#plot via par(mfrow()) the 3x3 and the 7x7 standard deviation
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

#original image plus the 7x7 sd
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)
#yellow/green line demonstrates a high variability, on the left where there is the white portion there can be snow or clouds in the middle 
#high sd can mean high variability or geologically varibaility
#how to chose the layer in which we apply the method? we use multivariate analysis
