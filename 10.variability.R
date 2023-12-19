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
