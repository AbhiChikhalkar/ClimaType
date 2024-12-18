//
//  DailyForecast.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/18/24.
//


import Foundation

/// Represents daily weather data for the 5-day forecast
struct DailyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let maxTemperature: Float
    let minTemperature: Float
    let uvIndexMax: Float
    let precipitationSum: Float
}