//
//  ForecastView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var weatherManager: WeatherManager
    
    @State private var weather: WeatherModel?
    @State private var forecast: ForecastModel?
    @State private var showingPlaceholder = false
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let forecast = forecast, let weather = weather {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(weather.name)
                            .bold()
                            .font(.title)
                        ForEach(dailyForecasts(from: forecast.list), id: \.dt) { forecast in
                            OneDayRowWeather(text: formattedDate(from: forecast.dt), value: forecast.main.temp.doubleToString())
                        }
                    }
                    .padding(20)
                } else if showingPlaceholder {
                    SavedForecastView()
                } else {
                    ProgressView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                forecast = try await weatherManager.getFiveDayForecast(latitude: location.latitude, longitude: location.longitude)
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
    
    func formattedDate(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: date)
    }
    
    func dailyForecasts(from forecastList: [ForecastModel.ForecastTime]) -> [ForecastModel.ForecastTime] {
        var dailyForecasts: [ForecastModel.ForecastTime] = []
        let calendar = Calendar.current

        let groupedByDay = Dictionary(grouping: forecastList) { forecastTime -> Date in
            let date = Date(timeIntervalSince1970: TimeInterval(forecastTime.dt))
            return calendar.startOfDay(for: date)
        }

        for (_, forecastsForDay) in groupedByDay {
            if let forecastForNoon = forecastsForDay.first {
                dailyForecasts.append(forecastForNoon)
            }
        }

        let result = Array(dailyForecasts.sorted(by: { $0.dt < $1.dt }).prefix(5))
        
        PersistenceController.shared.saveForecastData(result)
        
        return result
    }
}
