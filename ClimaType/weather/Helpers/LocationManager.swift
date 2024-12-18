//
//  LocationManager.swift
//  weather
//
//  Created by Abhishek Chikhalkar on 12/17/24.
//


import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D? // This will hold the current location.
    @Published var savedLocations: [Location] = []

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func addLocation(name: String, latitude: Double, longitude: Double) {
        let newLocation = Location(name: name, latitude: latitude, longitude: longitude)
        if !savedLocations.contains(newLocation) {
            savedLocations.append(newLocation)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = location.coordinate // Update currentLocation when new data arrives.
            }
        }
    }
}
