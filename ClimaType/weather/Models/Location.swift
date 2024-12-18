//
//  Location.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/18/24.
//


import Foundation
import CoreLocation

struct Location: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}