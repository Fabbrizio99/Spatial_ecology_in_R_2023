# vegetation indices
# NIR reflectance tells us if the vegetation is in a good state, the RED reflectance in this case should be low
# if the tree is suffering, the reflectance of the NIR will be lower and the RED will be higher
# DVI is an index given by NIR - RED, so it's going to be low if the vegetation is in bad conditions
# NDVI is thee normalization (values between 0 and 1), NDVI= DVI-RED/DVI+RED

library(imageRy)
library(terra)

im.list()
# import an image from 1992 of the forest
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3) #it's the same, shortcut
im.plotRGB(m1992, r=2, g=1, b=3) # here we have vegetation that is green and soil is violet
im.plotRGB(m1992, r=2, g=3, b=1) # vegetation is blue


# import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

#build a multiframe with 1992 and 2006 images (with the par function)
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# we want to use the DVI to see the healt state of the vegetation
plot(m1992[[1]])#it gives us the plot only from the first band (NIR), the maximum on the y axe is 255 because we are speaking about bit 

# DVI = NIR - RED , difference between the first two bands 
dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992)
# for each pixel wee have the difference between the two bands, everything in green is healthy forest

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)
#let's do the same for 2006
plot(m2006)
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)
#we see now healty vegetation is a very small amount, as deforestation is destroying the forest

# if we have images with different bits we have to standardize the bit (normalized) 
# NDVI=NIR-RED/NIR+RED
# Range of NDVI is always from -1 to 1 , DVI is ranging depending on the bits we have (-256, +256 if we have 8 bits)
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

# we do the same for 2006
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)
# we can see results of deforestation, in fact healthy vegetation is a small area

par(mfrow=c(1,2)) # plotting the two images together, creating a multiframe
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl) # in 2006 the situation is worse 

#to use colors for daltonic
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
plot(ndvi2006, col=clvir)
plot(ndvi1992, col=clvir)

#speeding up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) #don't need to write the whole formula 
plot(ndvi2006, col=cl)
