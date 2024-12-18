import SwiftUI
import OpenMeteoSdk
import CoreLocation

struct WeatherApp: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var showLocationSheet = false
    @State private var showDetails = false

    var body: some View {
        ZStack {
            // Background Gradient
            WeatherGradientView(condition: weatherViewModel.currentCondition)

            // Main Weather Display
            VStack {
                Spacer()
                WeatherTextView(condition: weatherViewModel.currentCondition)
                Spacer()
            }
            .onLongPressGesture(
                minimumDuration: 0.5,
                pressing: { isPressing in
                    withAnimation {
                        showDetails = isPressing
                    }
                },
                perform: {}
            )

            // Location Selector Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showLocationSheet.toggle()
                    }) {
                        Image(systemName: "location.circle")
                            .font(.title)
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchDefaultWeather()
        }
        .sheet(isPresented: $showLocationSheet) {
            LocationSheet(weatherViewModel: weatherViewModel, locationManager: locationManager)
        }
        .sheet(isPresented: $showDetails) {
            if let currentLocation = locationManager.currentLocation {
                WeatherDetailsView(
                    location: weatherViewModel.locationName,
                    temperature: weatherViewModel.currentTemperature,
                    humidity: Int(weatherViewModel.currentHumidity),
                    precipitation: weatherViewModel.currentPrecipitation,
                    windSpeed: weatherViewModel.currentWindSpeed,
                    dailyForecast: weatherViewModel.dailyForecast
                )
            } else {
                Text("Location not available")
            }
        }
    }

    private func fetchDefaultWeather() {
        if let location = locationManager.currentLocation {
            Task {
                await weatherViewModel.fetchWeather(
                    lat: location.latitude,
                    lon: location.longitude,
                    locationName: "Current Location"
                )
            }
        } else {
            // Fallback to Naples, Italy
            Task {
                await weatherViewModel.fetchWeather(
                    lat: 40.8518,
                    lon: 14.2681,
                    locationName: "Naples, Italy"
                )
            }
        }
    }
}

struct WeatherApp_Previews: PreviewProvider {
    static var previews: some View {
        WeatherApp()
    }
}
