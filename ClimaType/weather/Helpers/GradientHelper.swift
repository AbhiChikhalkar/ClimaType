//
//  GradientHelper.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct GradientHelper {
    static func colors(for condition: String) -> [Color] {
        switch condition.lowercased() {
        case "clear":
            return [Color.blue, Color.orange] // Clear sky
        case "partly cloudy":
            return [Color.gray, Color.yellow] // Partly cloudy
        case "fog":
            return [Color.gray, Color.white] // Fog
        case "drizzle", "rain":
            return [Color.blue, Color.gray] // Rain or drizzle
        case "freezing rain":
            return [Color.cyan, Color.white] // Freezing rain
        case "snow":
            return [Color.white, Color.cyan] // Snow
        case "snow grains":
            return [Color.white, Color.gray] // Snow grains
        case "rain showers":
            return [Color.blue, Color.cyan] // Rain showers
        case "snow showers":
            return [Color.white, Color.blue] // Snow showers
        case "thunderstorm":
            return [Color.purple, Color.gray] // Thunderstorm
        case "thunderstorm with hail":
            return [Color.purple, Color.white] // Thunderstorm with hail
        default:
            return [Color.black, Color.gray] // Unknown condition
        }
    }
}
