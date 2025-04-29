library(devtools)
devtools::install_github("clauswilke/colorblindr")
library(colorblindr)
library(ggplot2)

iris
fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
plot(fig)

cvd_grid(fig)
