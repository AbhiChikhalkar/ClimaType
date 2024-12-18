//
//  HourlyWeatherView.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct HourlyWeatherView: View {
    let hourlyWeather: [HourlyWeather]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(hourlyWeather) { weather in
                    VStack {
                        Text(timeFormatter.string(from: weather.time))
                            .font(.caption)
                        Text("\(weather.temperature, specifier: "%.1f")°C")
                            .font(.headline)
                        Text("Precip: \(weather.precipitationProbability, specifier: "%.0f")%")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 70)
                }
            }
            .padding()
        }
    }
}

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()