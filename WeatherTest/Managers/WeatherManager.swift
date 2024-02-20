//
//  WeatherManager.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import Foundation
import CoreLocation
import SwiftUI

final class  WeatherManager: ObservableObject {
    //Open Weather Api
    let apiKey = "0ada91d884a9cd1c0fc3138ac7f29a5d"
    
    //для получения погоды на текущий день
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherModel {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else { fatalError("Something wrong...")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, res) = try await URLSession.shared.data(for: urlRequest)
        
        guard (res as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
        
        return decodedData
    }
    
    //для получения погоды на следующие 5 дней
    func getFiveDayForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastModel {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            fatalError("Invalid URL")
        }
        let urlRequest = URLRequest(url: url)
        
        let (data, res) = try await URLSession.shared.data(from: url)
        
        guard (res as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let forecast = try JSONDecoder().decode(ForecastModel.self, from: data)
        
        return forecast
    }
    
    //для получения погоды по выбранному городу
    func getWeatherByCityName(cityName: String) async throws -> WeatherModel {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            fatalError("Invalid URL")
        }

        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data for city")
        }

        let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)

        return decodedData
    }
}

