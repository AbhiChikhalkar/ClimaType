//
//  WeatherGradientView.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI

struct WeatherGradientView: View {
    let condition: String

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: GradientHelper.colors(for: condition)),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}
