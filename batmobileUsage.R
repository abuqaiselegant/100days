# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
library(fitdistrplus)

# Load the data
data <- read_csv("BatMobile_Usage_20700215.csv")

# Check the first few rows of the data
head(data)

# Rename columns for clarity
colnames(data) <- c("Manufacturer_A", "Manufacturer_B", "Manufacturer_C")

# Summary statistics for each manufacturer
summary_stats <- summary(data)
print("Summary Statistics:")
print(summary_stats)        

# Calculate standard deviation for each manufacturer
sd_A <- sd(data$Manufacturer_A, na.rm = TRUE)
sd_B <- sd(data$Manufacturer_B, na.rm = TRUE)
sd_C <- sd(data$Manufacturer_C, na.rm = TRUE)

# Print standard deviations
print(paste("Standard Deviation for Manufacturer A: ", round(sd_A, 4)))
print(paste("Standard Deviation for Manufacturer B: ", round(sd_B, 4)))
print(paste("Standard Deviation for Manufacturer C: ", round(sd_C, 4)))

# Boxplots for each manufacturer
boxplot(data, main = "Usage Lifetime by Manufacturer", 
        col = c("lightblue", "lightgreen", "lightpink"),
        names = c("Manufacturer A", "Manufacturer B", "Manufacturer C"),
        ylab = "Usage Lifetime (minutes)")

#Histogram for each manufacturer
# Set layout for side-by-side plots
par(mfrow = c(1, 3))

# Plot histograms for each manufacturer
hist(data$Manufacturer_A,
     col = "lightblue",
     main = "Manufacturer A",
     xlab = "Usage Lifetime (minutes)",
     breaks = 10)

hist(data$Manufacturer_B,
     col = "lightgreen",
     main = "Manufacturer B",
     xlab = "Usage Lifetime (minutes)",
     breaks = 10)

hist(data$Manufacturer_C,
     col = "lightpink",
     main = "Manufacturer C",
     xlab = "Usage Lifetime (minutes)",
     breaks = 10)

# Reset layout
par(mfrow = c(1, 1))


# Plot density plots for each manufacturer
plot(density(data$Manufacturer_A), 
     main = "Density Plot of Usage Lifetime by Manufacturer", 
     xlab = "Usage Lifetime (minutes)", 
     ylab = "Density", 
     col = "blue", 
     lwd = 2, 
     xlim = range(c(data$Manufacturer_A, data$Manufacturer_B, data$Manufacturer_C)))

lines(density(data$Manufacturer_B), col = "green", lwd = 2)
lines(density(data$Manufacturer_C), col = "red", lwd = 2)

legend("topright", legend = c("Manufacturer A", "Manufacturer B", "Manufacturer C"), 
       col = c("blue", "green", "red"), lwd = 2)


#Construct a 85% confidence interval for the mean usage lifetime (minutes) for a TurboBM battery in a
#mobile device produced by manufacturer B.

n <- length(data$Manufacturer_B)  #  size
mean <- mean(data$Manufacturer_B)  # Sample mean
var <- var(data$Manufacturer_B)  # Sample variance


# Confidence level
confidence_level <- 0.85
alpha <- 1 - confidence_level

# Calculate critical t-value
t_critical <- qt(1 - alpha / 2, df = n - 1)

# Calculate standard error
standard_error <- sqrt(var / n)

# Calculate margin of error
margin_of_error <- t_critical * standard_error

# Calculate confidence interval
lower_bound <- mean - margin_of_error
upper_bound <- mean + margin_of_error

# Print results
cat("85% Confidence Interval for Manufacturer B: [", lower_bound, ", ", upper_bound, "]\n")


#2nd method
# Perform t-test for Manufacturer B with 85% confidence level
t_test_B <- t.test(data$Manufacturer_B, conf.level = 0.85)

# Extract the confidence interval
cat("85% Confidence Interval for Manufacturer B:", t_test_B$conf.int, "\n")


#Test whether or not a gamma distribution is appropriate for the usage lifetime (minutes) of a TurboBM
#battery in a mobile device produced by manufacturer A.
#You may test whether a Gamma(13, 0.0328) distribution is appropriate, if you are unable to find an
#appropriate gamma distribution to fit using the data.

# Extract Manufacturer A data
#Manufacturer_A <- data$A

# Calculate sample mean and variance
mean_A <- mean(data$Manufacturer_A)
var_A <- var(data$Manufacturer_A)

# Fit Gamma distribution parameters
alpha <- round(mean_A^2 / var_A, 4)  # Shape parameter
beta <- round(mean_A / var_A, 4)    # Rate parameter

# Plot histogram and fitted Gamma distribution
hist(data$Manufacturer_A, freq = FALSE, main = "Gamma Fit for Manufacturer A", xlab = "Usage Lifetime (minutes)")
x <- seq(min(data$Manufacturer_A), max(data$Manufacturer_A), by = 1)
y <- dgamma(x, shape = alpha, rate = beta)
lines(x, y, col = "red")

# Print results
cat("Fitted Gamma Parameters:\n")
cat("Alpha (Shape):", alpha, "\n")
cat("Beta (Rate):", beta, "\n")


fit_gamma<- fitdist(data$Manufacturer_A,"gamma",method="mle")
ks_test <-ks.test(data$Manufacturer_A, "pgamma", shape = fit_gamma$estimate[1],rate = fit_gamma$estimate[2])
fit_gamma$estimate
ks_test
