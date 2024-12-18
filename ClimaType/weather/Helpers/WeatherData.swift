//
//  WeatherData.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//

import Foundation

/// Represents the weather data returned by the API
struct WeatherData {
    struct Hourly {
        let time: [Date] // Array of hourly timestamps
        let temperature2m: [Float] // Hourly temperatures at 2m
        let precipitationProbability: [Float] // Probability of precipitation
        let windSpeed: [Float] // Hourly wind speeds at 10m
    }

    struct Daily {
        let time: [Date] // Array of daily timestamps
        let temperature2mMax: [Float] // Daily maximum temperatures
        let temperature2mMin: [Float] // Daily minimum temperatures
        let uvIndexMax: [Float] // Maximum UV index
        let precipitationSum: [Float] // Total precipitation
    }

    let hourly: Hourly
    let daily: Daily
    let currentHumidity: Float // Current relative humidity
    let condition: String // Current weather condition (e.g., Clear, Rain)
}
