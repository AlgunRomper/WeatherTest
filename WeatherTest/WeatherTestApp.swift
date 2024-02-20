//
//  WeatherTestApp.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

@main
struct weatherTestApp: App {
    let persistenceController = PersistenceController.shared
    @State private var locationManager = LocationManager()
    @State private var weatherManager = WeatherManager()
    @State private var modelData = ViewModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationManager)
                .environmentObject(weatherManager)
                .environmentObject(modelData)
                .onAppear {
                    locationManager.requestLocation()
                }
        }
    }
}
