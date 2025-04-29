# we maintain just the header from RStudio
# to compile we use knit
---
title: "markdownreport"
author: "Mattia Fabris"
date: "2024-01-09"
output: html_document
---

# My first markdown document!

Here you can add some text
# to enter the code we use: ``` 
# then we want to evakuate if the code is equal to something by saying: {r, eval=T}
in this case you attain result:
```{r, eval=T}
2+3
``` # here we close the code
# if we put eval equal to F we will not see the result
in this case you do not
```{r, eval=F}
2+3
```

Using proper packages: the imageRy package has been built in alma mater
```{r, eval=F}
library(imageRy)
```

Let's import some data, starting with a list of file
```{r, eval=F}
im.list()
```

Importing the mato grosso area image:
```{r, eval=T}
mato1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
```

Let's plot with RGB by plotting the NIR in the green band
```{r, eval=T}
im.plotRGB(mato1992, r=2, g=1, b=3)
```

How to remove the warning? 
```{r, eval=T, warning=F}
mato1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
```

Plotting several images all together
```{r, eval=T, warning=F}
par(mfrow=c(2,2))
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato1992, r=3, g=1, b=2)
im.plotRGB(mato1992, r=2, g=3, b=1)
```

Calculating spectral indices with viridis palette so that also colour-blind people can see it
```{r, eval=T}
library(terra)
library(viridis)
dvi<-mato1992[[1]]-mato1992[[2]]
viridisc<-colorRampPalette(viridis(7))(255)
plot(dvi,col=viridisc)
```

Calculating variability
```{r, eval=T}
sd3<-focal(mato1992[[1]], matrix(1/25, 5, 5), fun=sd)
plot(sd3, col=viridisc)
```
