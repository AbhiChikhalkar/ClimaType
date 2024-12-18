//
//  WeatherMetricView.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct WeatherMetricView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
    }
}