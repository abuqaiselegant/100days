library(ggplot2)

data <- read.csv("Surgery_20700215.csv")
head(data)

#EDA
summary(data$New.surgery)
sd(data$New.surgery)

summary(data$Current.surgery)
sd(data$Current.surgery)

#Visualization
# 1Histogram for New.surgery and Current.surgery
ggplot(data, aes(x = New.surgery)) + 
  geom_histogram(binwidth = 1, fill = "green") +
  labs(title = "Histogram of Hospital Stays - New Surgery", x = "Total stays(days)", y = "Frequency")


ggplot(data, aes(x = Current.surgery)) + 
  geom_histogram(binwidth = 1, fill = "red") +
  labs(title = "Histogram of Hospital Stays - Current Surgery", x = "Total stays(days)", y = "Frequency")


# 2Boxplot comparison
boxplot(data$New.surgery, data$Current.surgery, 
        names = c("New Surgery", "Current Surgery"),
        main = "Boxplot of Hospital Stays",
        ylab = "Length of Stay (days)", 
        col = c("green", "red"))

# 1. One-Sample t-Test for New.surgery against benchmark (8 days)
t_test_new <- t.test(data$New.surgery, mu = 8, alternative = "less")
cat("One-sample t-test for New Surgery vs. 8 days:\n")
print(t_test_new)


# 2. Paired t-Test for New.surgery and Current.surgery
paired_t_test <- t.test(data$New.surgery, data$Current.surgery, paired = TRUE, alternative = "less")
cat("\nPaired t-test for New Surgery vs. Current Surgery:\n")
print(paired_t_test)

# Calculate descriptive statistics
mean_diff <- mean(data$New.surgery - data$Current.surgery)
conf_interval <- t.test(data$New.surgery, data$Current.surgery, paired = TRUE)$conf.int
sd_diff <- sd(data$New.surgery - data$Current.surgery)
n <- length(data$New.surgery)


cat("\nDescriptive Statistics:\n")
cat("\nMean difference between New and Current Surgery:", mean_diff, "\n")
cat("Standard deviation of differences:", round(sd_diff, 3), "days\n")
cat("Sample size:", n, "\n")
cat("95% Confidence Interval for the difference:", conf_interval, "\n")
