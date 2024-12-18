//
//  LocationSheet.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import SwiftUI
import CoreLocation

struct LocationSheet: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @ObservedObject var locationManager: LocationManager

    @State private var newLocationName = ""

    var body: some View {
        NavigationView {
            VStack {
                // Add New Location
                HStack {
                    TextField("Enter location", text: $newLocationName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Add") {
                        searchForLocation(name: newLocationName)
                    }
                }

                // Saved Locations List
                List {
                    // Current Location
                    if let currentLocation = locationManager.currentLocation {
                        Button("Current Location") {
                            Task {
                                await weatherViewModel.fetchWeather(
                                    lat: currentLocation.latitude,
                                    lon: currentLocation.longitude,
                                    locationName: "Current Location"
                                )
                            }
                        }
                    }

                    // Saved Locations
                    ForEach(locationManager.savedLocations) { location in
                        Button(location.name) {
                            Task {
                                await weatherViewModel.fetchWeather(
                                    lat: location.latitude,
                                    lon: location.longitude,
                                    locationName: location.name
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Locations")
        }
    }

    /// Geocode a location name to coordinates
    private func searchForLocation(name: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, _ in
            if let placemark = placemarks?.first, let location = placemark.location {
                locationManager.addLocation(
                    name: name,
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
                newLocationName = ""
            }
        }
    }
}
