install.packages("imageRy")

library(imageRy)
library(terra)

#list the data
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")

cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col=cl)

# import the green band from sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif")
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col=cl)
