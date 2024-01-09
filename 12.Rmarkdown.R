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
