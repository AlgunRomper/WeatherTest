//
//  ForecastModel.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import Foundation

struct ForecastModel: Codable {
    let list: [ForecastTime]
    
    struct ForecastTime: Codable {
        let dt: Int
        let main: MainClass
        let weather: [Weather]
        let dt_txt: String
        
        struct MainClass: Codable {
            let temp: Double
        }
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
    }
}
