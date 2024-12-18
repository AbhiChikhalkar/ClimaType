//
//  WeatherIconHelper.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct WeatherIconHelper {
    static func icon(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear": return "sun.max.fill"
        case "rain": return "cloud.rain.fill"
        case "clouds": return "cloud.fill"
        case "snow": return "snow"
        default: return "questionmark.circle.fill"
        }
    }
}