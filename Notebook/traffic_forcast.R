# ===========================
# Traffic Flow Forecast Project
# ===========================

# Load libraries
#install.packages("forecast")
library(forecast)
library(ggplot2)

# Simulate Traffic Flow Data (60 days)
set.seed(42)
days <- 1:60
# Weekday (Mon–Fri) higher traffic, Weekend lower traffic
traffic <- 3000 + 200*sin(2*pi*days/7) + rnorm(60, mean=0, sd=150)

# Create a time series object
traffic_ts <- ts(traffic, frequency = 7)  # weekly seasonality

# Visualize Data
autoplot(traffic_ts) +
  ggtitle("Daily Traffic Flow (Simulated)") +
  xlab("Days") + ylab("Traffic Volume")

# Fit ARIMA Model
fit <- auto.arima(traffic_ts)
summary(fit)

# Forecast Next 14 Days
forecast_traffic <- forecast(fit, h = 14)

# Plot Forecast
autoplot(forecast_traffic) +
  ggtitle("Traffic Flow Forecast (Next 14 Days)") +
  xlab("Days") + ylab("Traffic Volume")

# Save dataset
traffic_data <- data.frame(Day = days, Traffic_Volume = traffic)
write.csv(traffic_data, "traffic_flow_data.csv", row.names = FALSE)

ggsave("traffic_forecast_plot.png")

