# Load the necessary library
library(readr)

# Load the data
data <- read_csv("BatMobile_Comparison_20700215.csv")
head(data)

# Handling missing values
data_clean <- na.omit(data)


summary_stats <- summary(data_clean)
print("Summary Statistics:")
print(summary_stats)


# Check the dimensions of the plotting area
dev.size("px")

# Reset margins to even smaller values
par(mar = c(3, 3, 2, 1))

# Set up the plotting area for histograms
par(mfrow = c(1, 2))  # Arrange plots in 1 row and 2 columns

# Histogram for TurboBM usage lifetime
hist(data$TurboBM, breaks = 10, col = "blue", main = "TurboBM Usage Lifetime",
     xlab = "Usage Time (minutes)", ylab = "Frequency", border = "white")

# Histogram for BMClassic usage lifetime
hist(data$BMClassic, breaks = 10, col = "green", main = "BMClassic Usage Lifetime",
     xlab = "Usage Time (minutes)", ylab = "Frequency", border = "white")

# Reset plotting area for scatter plot
par(mfrow = c(1, 1))

# Adjust margins for scatter plot
par(mar = c(3, 3, 2, 1))

# Scatter plot to visualize correlation
plot(data$BMClassic, data$TurboBM, col = "red", pch = 19,
     main = "Scatter Plot of TurboBM vs BMClassic",
     xlab = "BMClassic Usage (minutes)", ylab = "TurboBM Usage (minutes)")
abline(lm(data$TurboBM ~ data$BMClassic), col = "blue")  # Add a regression line
grid()

# Calculate the correlation
correlation <- cor(data_clean$TurboBM, data_clean$BMClassic)

cor.test(data_clean$TurboBM,data_clean$BMClassic)

# Print the correlation result
print(paste("Correlation between TurboBM and BMClassic:", round(correlation, 3)))

#scatterplot with smoothing line
library(ggplot2)

ggplot(data, aes(x = BMClassic, y = TurboBM)) +
  geom_point(color = "blue") +
  geom_smooth(method = "loess", color = "red") +
  labs(title = "Scatter Plot with Smoothing Line",
       x = "BMClassic Usage (minutes)", y = "TurboBM Usage (minutes)")

#heatmap of correlation mateix
library(corrplot)

# Calculate the correlation matrix
cor_matrix <- cor(data_clean)

# Plot the heatmap
corrplot(cor_matrix, method = "color", type = "upper",
         title = "Heatmap of Correlation Matrix",
         col = colorRampPalette(c("blue", "white", "red"))(200))

#for 2(c)
# Perform F-test to compare variances
f_test <- var.test(data_clean$TurboBM, data_clean$BMClassic)

# Print the F-test result
print(f_test)

# Calculate the difference between the means
mean_diff <-mean(data_clean$TurboBM)-mean(data_clean$BMClassic)
print(mean_diff)

# Perform a one-sided t-test
t_test_result <- t.test(data_clean$TurboBM, data_clean$BMClassic, 
                        alternative = "greater", mu = 65)
# Display the results
print(t_test_result)
