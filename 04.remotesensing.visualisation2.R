

install.package("devtools")

library(devtools)
#to install packages directly from github
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)

im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
b2
