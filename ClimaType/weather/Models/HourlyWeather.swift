//
//  HourlyWeather.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/18/24.
//


import Foundation

/// Represents individual hourly weather data for display in the forecast
struct HourlyWeather: Identifiable {
    let id = UUID()
    let time: Date
    let temperature: Float
    let precipitationProbability: Float
}