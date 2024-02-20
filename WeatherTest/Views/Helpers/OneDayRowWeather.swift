//
//  OneDayRowWeather.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI

struct OneDayRowWeather: View {
    var text: String
    var value: String
    
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(value)
        }
        .padding(13)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white.opacity(0.4))
        .cornerRadius(10)
    }
}
