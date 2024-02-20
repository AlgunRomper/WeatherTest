//
//  CurrentWeatherView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct CurrentWeatherView: View {
    var weather: WeatherModel
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
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
                        
                        Text(weather.main.feelsLike.doubleToString() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }

                    VStack(spacing: 15) {
                        OneDayRowWeather(text: "Мин. температура", value: weather.main.tempMin.doubleToString() + "°")
                        OneDayRowWeather(text: "Макс. температура", value: weather.main.tempMax.doubleToString() + "°")
                        OneDayRowWeather(text: "Скорость ветра", value: weather.wind.speed.doubleToString() + "м/с")
                        OneDayRowWeather(text: "Влажность", value: weather.main.humidity.doubleToString() + "%")
                    }
                }
            }
            .padding()
        }
    }
    
    func recomendation() -> String {
        if weather.main.feelsLike < 0 {
            return "Температура меньше 0 градусов"
        } else if weather.main.feelsLike >= 0 && weather.main.feelsLike <= 15 {
            return "Температура от 0 до 15 градусов"
        } else {
            return "Температура выше 15 градусов"
        }
    }
}
