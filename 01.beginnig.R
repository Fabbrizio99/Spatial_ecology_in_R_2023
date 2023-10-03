# here I can write anything you want, and nothing can happen. It is useful to make viewers to undersant what you are doing

# R as a calculaotor 
2+3

# assing to an object
zima <- 2+3
zima

duccio <- 5+3
duccio

final <- zima*duccio
final

final^2

# array, a series of numbers put together 
sophie <- c(10,20,30,50,70) #microplastics, numbers are called arguments and functions have parentheses

paula <- c(100,500,600,1000,2000) #people

plot(paula , sophie)

plot(paula , sophie, xlab="number of people", ylab="microplastics")

people <- paula
microplastics <- sophie

plot(people, microplastics)

#http://www.sthda.com/sthda/RDoc/images/points-symbols.png

plot(people, microplastics, pch=19)

plot(people, microplastics, pch=19, cex=2)

plot(people, microplastics, pch=19, cex=2, col="blue")
