//
//  SavedForecastView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct SavedForecastView: View {
    var savedWeather: [String] {
        PersistenceController.shared.loadSavedWeather()
    }
    
    var savedForecast: [Double] {
        PersistenceController.shared.loadSavedForecast()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(savedWeather[0])
                .bold()
                .font(.title)
            ForEach(savedForecast, id: \.self) { forecast in
                let index = savedForecast.firstIndex(of: forecast)!
                OneDayRowWeather(text: formattedDate(from: index), value: forecast.doubleToString())
            }
        }
        .padding(20)
    }
    
    func formattedDate(from index: Int) -> String {
        let calendar = Calendar.current
        guard let futureDate = calendar.date(byAdding: .day, value: index, to: Date()) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: futureDate)
    }
}
