//
//  SearchView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var weatherManager: WeatherManager
    @State private var cityName: String = ""
    @State private var showWeatherDetails = false
    @State private var weather: WeatherModel?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                HStack {
                    TextField("Введите название города", text: $cityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .cornerRadius(10)
                    
                    Button {
                        Task {
                            await searchWeather()
                        }
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                .padding()
                
                if let weather = weather {
                    CurrentWeatherView(weather: weather)
                } else {
                    Spacer()
                }
            }
        }
    }
    
    func searchWeather() async {
        do {
            weather = try await weatherManager.getWeatherByCityName(cityName: cityName)
        } catch {
            print("Ошибка при получении данных о погоде: \(error)")
        }
    }
}
