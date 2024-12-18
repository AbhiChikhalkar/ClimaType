//
//  WeatherViewModel.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentTemperature: Float = 0.0
    @Published var currentCondition: String = "Clear"
    @Published var currentHumidity: Float = 0.0
    @Published var currentPrecipitation: Float = 0.0
    @Published var currentWindSpeed: Float = 0.0
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyForecast: [DailyForecast] = []
    @Published var locationName: String = "Your Location"

    func fetchWeather(lat: Double, lon: Double, locationName: String? = nil) async {
        do {
            let weatherData = try await WeatherDataAPI.shared.fetchWeatherData(lat: lat, lon: lon)
            if let name = locationName { self.locationName = name }
            self.currentTemperature = weatherData.hourly.temperature2m.first ?? 0.0
            self.currentCondition = weatherData.condition
            self.currentHumidity = weatherData.currentHumidity
            self.currentPrecipitation = weatherData.daily.precipitationSum.first ?? 0.0
            self.currentWindSpeed = weatherData.hourly.windSpeed.first ?? 0.0
            self.hourlyWeather = weatherData.hourly.time.enumerated().map {
                HourlyWeather(time: $1, temperature: weatherData.hourly.temperature2m[$0], precipitationProbability: weatherData.hourly.precipitationProbability[$0])
            }
            self.dailyForecast = weatherData.daily.time.enumerated().map {
                DailyForecast(
                    date: $1,
                    maxTemperature: weatherData.daily.temperature2mMax[$0],
                    minTemperature: weatherData.daily.temperature2mMin[$0],
                    uvIndexMax: weatherData.daily.uvIndexMax[$0],
                    precipitationSum: weatherData.daily.precipitationSum[$0]
                )
            }
        } catch {
            print("Error fetching weather data: \(error)")
        }
    }
}
