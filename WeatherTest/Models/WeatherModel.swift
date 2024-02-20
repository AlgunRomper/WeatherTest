//
//  WeatherModel.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import Foundation


struct WeatherModel: Decodable {
    
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension WeatherModel.MainResponse {
    var feelsLike: Double {
        return feels_like
    }
    var tempMin: Double {
        return temp_min
    }
    var tempMax: Double {
        return temp_max
    }
}
