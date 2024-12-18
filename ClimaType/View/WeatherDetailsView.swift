//
//  WeatherDetailsView.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct WeatherDetailsView: View {
    let location: String
    let temperature: Float
    let humidity: Int
    let precipitation: Float
    let windSpeed: Float
    let dailyForecast: [DailyForecast]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Location and Temperature
                VStack {
                    Text(location)
                        .font(.title)
                        .foregroundColor(.white)
                    Text("\(String(format: "%.1f", temperature))°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                // Metrics
                HStack(spacing: 20) {
                    WeatherMetricView(title: "Humidity", value: "\(humidity)%")
                    WeatherMetricView(title: "Precipitation", value: "\(String(format: "%.1f", precipitation)) mm")
                    WeatherMetricView(title: "Wind", value: "\(String(format: "%.1f", windSpeed)) km/h")
                }

                // 5-Day Forecast Table
                VStack(alignment: .leading, spacing: 10) {
                    Text("5-Day Forecast")
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(dailyForecast) { forecast in
                        HStack {
                            Text(dayFormatter.string(from: forecast.date)) // Day of the week
                                .frame(width: 80, alignment: .leading)
                                .foregroundColor(.white)

                            Text(dateFormatter.string(from: forecast.date)) // Date
                                .frame(width: 50, alignment: .leading)
                                .foregroundColor(.yellow)

                            Spacer()
                            Text("H: \(String(format: "%.1f", forecast.maxTemperature))°C")
                                .foregroundColor(.white)
                            Text("L: \(String(format: "%.1f", forecast.minTemperature))°C")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

private let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE" // Day of the week
    return formatter
}()

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd" // Only day of the month
    return formatter
}()
