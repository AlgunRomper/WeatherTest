//
//  Persistence.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WeatherDataModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController {
    func saveWeatherData(_ currentWeather: WeatherModel?) {
        let viewContext = container.viewContext
        
        // Попытка найти существующую запись или создать новую
        let fetchRequest: NSFetchRequest<WeatherDataModel> = WeatherDataModel.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let weather: WeatherDataModel
        do {
            let results = try viewContext.fetch(fetchRequest)
            weather = results.first ?? WeatherDataModel(context: viewContext)
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")
            return
        }
        
        weather.location = currentWeather?.name ?? ""
        weather.temp = currentWeather?.main.temp ?? 0
        weather.minTemp = currentWeather?.main.tempMin ?? 0
        weather.maxTemp = currentWeather?.main.tempMax ?? 0
        weather.wind = currentWeather?.wind.speed ?? 0
        weather.humidity = currentWeather?.main.humidity ?? 0
        
        do {
            try viewContext.save()
            print("Weather data saved successfully")
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func saveForecastData(_ forecasts: [ForecastModel.ForecastTime]) {
        guard forecasts.count >= 5 else {
            print("Insufficient forecast data to save")
            return
        }

        let viewContext = container.viewContext
        
        // Попытка найти существующую запись или создать новую
        let fetchRequest: NSFetchRequest<WeatherDataModel> = WeatherDataModel.fetchRequest()
        fetchRequest.fetchLimit = 1

        let weather: WeatherDataModel
        do {
            let results = try viewContext.fetch(fetchRequest)
            weather = results.first ?? WeatherDataModel(context: viewContext)
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")
            return
        }

        weather.temp2day = forecasts[0].main.temp
        weather.temp3day = forecasts[1].main.temp
        weather.temp4day = forecasts[2].main.temp
        weather.temp5day = forecasts[3].main.temp
        weather.temp6day = forecasts[4].main.temp

        do {
            try viewContext.save()
            print("Forecast data saved successfully")
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func loadSavedWeather() -> [String] {
        let viewContext = container.viewContext
        let fetchRequest: NSFetchRequest<WeatherDataModel> = WeatherDataModel.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        var result: [String] = []
        
        do {
            if let weather = try viewContext.fetch(fetchRequest).first {
                result.append(weather.location ?? "")
                result.append("\(weather.temp.doubleToString())")
                result.append("\(weather.minTemp.doubleToString())")
                result.append("\(weather.maxTemp.doubleToString())")
                result.append("\(weather.wind.doubleToString())")
                result.append("\(weather.humidity.doubleToString())")
                return result
            }
        } catch {
            print("Error fetching saved weather: \(error.localizedDescription)")
        }
        return result
    }
    
    func loadSavedForecast() -> [Double] {
        let viewContext = container.viewContext
        let fetchRequest: NSFetchRequest<WeatherDataModel> = WeatherDataModel.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        var result: [Double] = []
        
        do {
            if let forecast = try viewContext.fetch(fetchRequest).first {
                result.append(forecast.temp2day)
                result.append(forecast.temp3day)
                result.append(forecast.temp4day)
                result.append(forecast.temp5day)
                result.append(forecast.temp6day)
                return result
            }
        } catch {
            print("Error fetching saved weather: \(error.localizedDescription)")
        }
        return result
    }
}
