# Load the data
data <- read_csv("BatMobile_Laboratory_20700215.csv")
head(data)

# Remove rows with missing or non-positive temperature values
data <- data[!is.na(data$Temperature) & data$Temperature > 0, ]
data <- data[data$Temperature > 0, ]
data$Temperature_Squared <- data$Temperature^2

#model
model <- lm(Lifetime ~ Temperature, data = data)
model_transformed3 <- lm(Lifetime ~ Temperature_Squared, data = data)

# Scatter plot to visualize the relationship
plot(data$Temperature, data$Lifetime, 
     main = "Relationship between Usage Lifetime and Temperature",
     xlab = "Temperature (°C)", 
     ylab = "Usage Lifetime (hours)", 
)
abline(model, col = "red", lwd = 2)

# Scatter plot to visualize the relationship
plot(data$Temperature_Squared, data$Lifetime, 
     main = "Relationship between Usage Lifetime and TemperatureSquared",
     xlab = "TemperatureSquared (°C)", 
     ylab = "Usage Lifetime (hours)", 
     )
abline(model_transformed3, col = "red", lwd = 2)


hist(model$residuals, xlab="Residuals", freq=FALSE, main="Histogram of Residuals (Initial Model)")
curve(dnorm(x, mean=mean(model$residuals), sd=sd(model$residuals)), add=TRUE, col="blue")


hist(model_transformed3$residuals, xlab="Residuals", freq=FALSE, main="Histogram of Residuals (tempSquared Model)")
curve(dnorm(x, mean=mean(model_transformed3$residuals), sd=sd(model_transformed3$residuals)), add=TRUE, col="red")



#2ndQuestion

linear_model <- lm(Lifetime ~ ., data = data)
# Display the summary of the model to understand the relationship and significance of predictors
summary(linear_model)


linear_model$coefficients



#3rdQuestion

AIC(linear_model)

# Perform stepwise selection to refine the model
best_model <- step(linear_model)
best_model2 <- step(model_transformed3)

# Display the summary of the final selected model
summary(best_model)

best_model$coefficients
anova(best_model,model)


anova(best_model,linear_model,model_transformed3,model)
AIC(best_model)
# no need
# Compare AIC values between initial and final models
cat("AIC of the initial model:", AIC(linear_model), "\n")
cat("AIC of the best model:", AIC(best_model), "\n")


#no need
# Diagnostic plots for the selected model
par(mfrow = c(2, 2))  # Set up for 2x2 diagnostic plots
plot(best_model)


#4th questions
# Plot the residuals of the initial model

hist(best_model$residuals, xlab="Residuals", freq=FALSE, main="Histogram of Residuals (best Model)")
curve(dnorm(x, mean=mean(best_model$residuals), sd=sd(best_model$residuals)), add=TRUE, col="red")


#5th queestion
# Make predictions with a 75% prediction interval

# Prepare the new data for prediction
new_data <- data.frame(
  Temperature = 10.5,
  Temperature_Squared = 10.5^2,
  Recharge = 74,
  Device = "C",
  Memory = 32,
  Level = "Low"
)

pred <- predict(best_model, newdata = new_data, interval = "prediction", level = 0.75)

# Print the predictions
print(pred)


# Scatter plot to visualize the relationship with fitting curve
plot(data$Temperature, data$Lifetime, 
     main = "Relationship between Usage Lifetime and Temperature",
     xlab = "Temperature (°C)", 
     ylab = "Usage Lifetime (hours)")

# Add the regression line from the best model
temp_seq <- seq(min(data$Temperature), max(data$Temperature), length.out = 100)
new_data_fit <- data.frame(
  Temperature = temp_seq,
  Temperature_Squared = temp_seq^2,
  Recharge = mean(data$Recharge),  # Use mean or other appropriate value
  Device = "C",                    # Placeholder, adjust as necessary
  Memory = mean(data$Memory),      # Use mean or other appropriate value
  Level = "Low"                    # Placeholder, adjust as necessary
)

# Predict values using the best model for the fitting curve
predicted_values <- predict(best_model, newdata = new_data_fit)

# Add the fitting curve to the plot
lines(temp_seq, predicted_values, col = "blue", lwd = 2)












