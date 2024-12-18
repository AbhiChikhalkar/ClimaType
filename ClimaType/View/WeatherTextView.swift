//
//  WeatherTextView.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//

import SwiftUI

struct WeatherTextView: View {
    let condition: String

    var body: some View {
        VStack(spacing: 10) {
            Text(description(for: condition))
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 5)

            // Optional subtitle for additional context
            if let subtitle = subtitle(for: condition) {
                Text(subtitle)
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
        }
    }

    /// Returns the main description for the weather condition
    private func description(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "Bright and Sunny ☀️"
        case "partly cloudy":
            return "Partly Cloudy 🌤️"
        case "fog":
            return "Misty and Foggy 🌫️"
        case "drizzle":
            return "Light Drizzle 🌦️"
        case "rain":
            return "Rainy Weather 🌧️"
        case "freezing rain":
            return "Icy Rain ❄️🌧️"
        case "snow":
            return "Snowfall ❄️"
        case "snow grains":
            return "Snow Grains ❄️"
        case "rain showers":
            return "Rain Showers 🌦️"
        case "snow showers":
            return "Snow Showers 🌨️"
        case "thunderstorm":
            return "Thunderstorms Ahead ⛈️"
        case "thunderstorm with hail":
            return "Storms and Hail ⚡🌨️"
        default:
            return "Unknown Weather 🤷‍♂️"
        }
    }

    /// Returns an optional subtitle for additional context
    private func subtitle(for condition: String) -> String? {
        switch condition.lowercased() {
        case "clear":
            return "Enjoy the beautiful day!"
        case "rain", "drizzle", "rain showers":
            return "Don’t forget your umbrella!"
        case "snow", "snow grains", "snow showers":
            return "Stay warm and drive safely."
        case "thunderstorm", "thunderstorm with hail":
            return "Be cautious and stay indoors."
        default:
            return nil // No subtitle for other conditions
        }
    }
}
