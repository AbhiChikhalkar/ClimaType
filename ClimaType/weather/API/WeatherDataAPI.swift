import Foundation
import OpenMeteoSdk
import SwiftUI
import CoreLocation
class WeatherDataAPI {
    static let shared = WeatherDataAPI()
    private init() {}

    /// Fetches weather data from the Open-Meteo API for given latitude and longitude
    func fetchWeatherData(lat: Double, lon: Double) async throws -> WeatherData {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&hourly=temperature_2m,precipitation_probability,weathercode,relative_humidity_2m,windspeed_10m&daily=temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_sum&timeformat=unixtime&timezone=auto&format=json") else {
            throw NSError(domain: "WeatherDataAPI", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let responses: [WeatherApiResponse]
        do {
            responses = try await WeatherApiResponse.fetch(url: url)
        } catch {
            throw NSError(domain: "WeatherDataAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data from API."])
        }

        guard let response = responses.first else {
            throw NSError(domain: "WeatherDataAPI", code: 2, userInfo: [NSLocalizedDescriptionKey: "No response data available."])
        }

        let utcOffsetSeconds = response.utcOffsetSeconds
        guard let hourly = response.hourly, let daily = response.daily else {
            throw NSError(domain: "WeatherDataAPI", code: 3, userInfo: [NSLocalizedDescriptionKey: "Incomplete weather data."])
        }

        // Safely extract required data
        let weatherCode = Int(hourly.variables(at: 2)?.values.first ?? 0.0)
        let condition = mapWeatherCodeToCondition(weatherCode)
        let currentHumidity = hourly.variables(at: 4)?.values.first ?? 0.0

        return WeatherData(
            hourly: WeatherData.Hourly(
                time: hourly.getDateTime(offset: utcOffsetSeconds),
                temperature2m: hourly.variables(at: 0)?.values ?? [],
                precipitationProbability: hourly.variables(at: 1)?.values ?? [],
                windSpeed: hourly.variables(at: 3)?.values ?? []
            ),
            daily: WeatherData.Daily(
                time: daily.getDateTime(offset: utcOffsetSeconds),
                temperature2mMax: daily.variables(at: 0)?.values ?? [],
                temperature2mMin: daily.variables(at: 1)?.values ?? [],
                uvIndexMax: daily.variables(at: 2)?.values ?? [],
                precipitationSum: daily.variables(at: 3)?.values ?? []
            ),
            currentHumidity: currentHumidity,
            condition: condition
        )
    }

    /// Maps a weather code to a textual weather condition
    private func mapWeatherCodeToCondition(_ code: Int) -> String {
        switch code {
        case 0: return "Clear"
        case 1, 2, 3: return "Partly Cloudy"
        case 45, 48: return "Fog"
        case 51, 53, 55: return "Drizzle"
        case 61, 63, 65: return "Rain"
        case 66, 67: return "Freezing Rain"
        case 71, 73, 75: return "Snow"
        case 77: return "Snow Grains"
        case 80, 81, 82: return "Rain Showers"
        case 85, 86: return "Snow Showers"
        case 95: return "Thunderstorm"
        case 96, 99: return "Thunderstorm with Hail"
        default: return "Unknown"
        }
    }
}
