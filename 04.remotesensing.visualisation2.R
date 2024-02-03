

install.package("devtools")

library(devtools)
#to install packages directly from github
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)

# to see all the data in the package, all functions from imageRy start with im."something"
im.list()

#how to import data from the sentinel satellite from ESA
#we ewill use images with the same spacial resolution (10 meters), with 4 diffrent bands 
b2 <- im.import("sentinel.dolomites.b2.tif")
b2
