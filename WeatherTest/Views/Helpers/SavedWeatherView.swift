//
//  SavedWeatherView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct SavedWeatherView: View {
    var savedWeather: [String] {
        PersistenceController.shared.loadSavedWeather()
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 30) {
                VStack(alignment: .center, spacing: 5) {
                    Text(savedWeather[0])
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 30) {
                    HStack {
                        VStack(spacing: 20) {
                            Text(recomendation())
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(savedWeather[1] + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }

                    VStack(spacing: 15) {
                        OneDayRowWeather(text: "Мин. температура", value: savedWeather[2] + "°")
                        OneDayRowWeather(text: "Макс. температура", value: savedWeather[3] + "°")
                        OneDayRowWeather(text: "Скорость ветра", value: savedWeather[4] + "м/с")
                        OneDayRowWeather(text: "Влажность", value: savedWeather[5] + "%")
                    }
                }
            }
            .padding()
        }
    }
    
    func recomendation() -> String {
        if Int(savedWeather[1]) ?? 0 < 0 {
            return "Температура меньше 0 градусов"
        } else if Int(savedWeather[1]) ?? 0 >= 0 && Int(savedWeather[1]) ?? 0 <= 15 {
            return "Температура от 0 до 15 градусов"
        } else {
            return "Температура выше 15 градусов"
        }
    }
}
