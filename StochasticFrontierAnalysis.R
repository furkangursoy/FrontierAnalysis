install.packages("frontier") #download and install the necessary package
#install.packages("micEcon") # a dependency for frontier. it was failed to load or installed. so i installed it separately
#install.packages("maxLik") # a dependency for frontier. it was failed to load or installed. so i installed it separately
library(frontier) #load the packages

data <- read.table("sampledata.csv", sep="\t", header =TRUE)
summary(data)
names(data)
attach(data)


# single input, single output --without log
formula <- y1 ~ x1
result <- sfa(formula, data, truncNorm = FALSE)
summary(result)
result$modelType
result$ineffDecrease
result$icept
result$nn
result$nt
result$nob
result$timeEffect
result$olsParam
plot(data$y1, result$fitted, xlim = c(0,10), ylim = c(0,100))

plot(data$x1, result$fitted, xlim = c(0,10), ylim = c(0,100), pch=4) #visualize fitted values, actual values, and the ols line for actual values
par(new = TRUE)
plot(data$x1, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x1), col="red")
abline(lm(result$fitted~ data$x1), col="green")

sum(result$resid) #validate that sfa$result$resid is calculated correctly
sum(result$fitted - data$y1)
result$mleParam


lim <- lm(data$y1 ~ data$x1)
lim$coefficients #validate that lm coefficients and sfa$olsParam are the same.
result$olsParam[c(1:2)] 
mean(x1) * result$mleParam[2] + result$mleParam[1] #mleParam results in larger value than olsParam
mean(x1) * result$olsParam[2] + result$olsParam[1]


# single input, single output
formula <- log(y1) ~ log(x1)
result <- sfa(formula, data)

plot(x1, exp(result$fitted), xlim = c(0,10), ylim = c(0,100), pch=4)
par(new = TRUE)
plot(data$x1, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x1), col="red")

# two inputs, single output
formula <- log(y1) ~ log(x1) + log(x2)
result <- sfa(formula, data)

plot(x1, exp(result$fitted), xlim = c(0,10), ylim = c(0,100), pch=4, col="blue")
par(new = TRUE)
plot(data$x1, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x1), col="red")

plot(x2, exp(result$fitted), xlim = c(0,10), ylim = c(0,100), pch=4, col="blue")
par(new = TRUE)
plot(data$x2, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x2), col="red")


#test for negative, zero, -Inf, Inf values of x and y's. no error is produced
y1[c(10,20)] <- -1
y1[c(5,15)] <- 0
y1[c(3,13)] <- -Inf
y1[c(66,77)] <- Inf

x1[c(10,60)] <- -1 #for instance, for 10th observation both x1 and y1 is -1. so, we also check what if both x and y contains 'interesting' values at the same time
x1[c(95,15)] <- 0
x1[c(83,13)] <- -Inf
x1[c(99,77)] <- Inf


formula <- log(y1) ~ log(x1) + log(x2)
result <- sfa(formula, data)

plot(x1, exp(result$fitted), xlim = c(0,10), ylim = c(0,100), pch=4, col="blue")
par(new = TRUE)
plot(data$x1, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x1), col="red")

plot(x2, exp(result$fitted), xlim = c(0,10), ylim = c(0,100), pch=4, col="blue")
par(new = TRUE)
plot(data$x2, data$y1,  axes = FALSE, bty = "n", xlab = "", ylab = "", xlim = c(0,10), ylim = c(0,100))
abline(lm(data$y1 ~ data$x2), col="red")



