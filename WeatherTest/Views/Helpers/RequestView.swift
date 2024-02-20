//
//  RequestView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI
import CoreLocationUI

struct RequestView: View {
    @EnvironmentObject var locationManager: LocationManager

    @State private var pulsate = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Добро пожаловать в WeatherApp")
                .bold()
                .font(.title)
            
            Text("Для продолжения работы поделитесь Вашей геолокацией")
                .padding()
            
            LocationButton(.sendMyCurrentLocation, action: {
                locationManager.requestLocation()
            })
            .cornerRadius(15)
            .foregroundColor(.white)
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
