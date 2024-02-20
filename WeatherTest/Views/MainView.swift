//
//  MainView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var weatherManager: WeatherManager
    
    @State private var weather: WeatherModel?
    @State private var showingPlaceholder = false
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    CurrentWeatherView(weather: weather)
                        .onAppear {
                            PersistenceController.shared.saveWeatherData(weather)
                        }
                } else if showingPlaceholder {
                    SavedWeatherView()
                } else {
                    ProgressView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            }
                            catch {
                                showingPlaceholder = true
                                print("Error fetch \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    RequestView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.1))
    }
}
