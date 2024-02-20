//
//  Weather+CoreDataProperties.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//
//

import Foundation
import CoreData

extension WeatherDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherDataModel> {
        return NSFetchRequest<WeatherDataModel>(entityName: "WeatherDataModel")
    }

    @NSManaged public var location: String?
    @NSManaged public var temp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var maxTemp: Double
    @NSManaged public var wind: Double
    @NSManaged public var humidity: Double
    @NSManaged public var temp2day: Double
    @NSManaged public var temp3day: Double
    @NSManaged public var temp4day: Double
    @NSManaged public var temp5day: Double
    @NSManaged public var temp6day: Double

}

extension WeatherDataModel : Identifiable {

}
