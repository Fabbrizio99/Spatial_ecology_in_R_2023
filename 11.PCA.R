library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")
#how to choose the layer to which apply the sd calculation?
#here we chose NIR, but we need a method
#this method is the multivariate analysis

pairs(sent) 
#red and green are very correlated to each other (0.98 as pearson coefficient)
#nir is less correlated to the other bands, so it is adding some information

#perform PCA on sent
sentpc <- im.pca(sent)
sentpc
#sd is 77 in the first principal component
#the first component is pc1. we can separate it
pc1 <- sentpc$PC1
viridisc <- colorRampPalette(viridis(7))(255) #change the colours
plot(pc1, col=viridisc)

#calculating standard deviation on top of pc1
pc1sd3<-focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)
#we calculated on a single layer

pc1sd7<-focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)
#sd from the vaiability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

#we have chosen in a objective manner to choose the band on which to make the calculation


#stack all the standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7") 
plot(sdstack, col=viridisc)

