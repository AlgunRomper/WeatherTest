//
//  ContentView.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isActiveSearch: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Контент вкладок
            TabView(selection: $selectedTab) {
                MainView()
                    .tabItem {
                        Label("Main", systemImage: "thermometer.sun")
                    }
                    .tag(0)
                
                ForecastView()
                    .tabItem {
                        Label("Forecast", systemImage: "list.clipboard.fill")
                    }
                    .tag(1)
            }
            
            
            HStack {
                Spacer()
                
                //request Location (если не был предоставлен)
                    Button(action: {
                        isActiveSearch = true
                    }) {
                        Image(systemName: "location.magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isActiveSearch, content: {
            SearchView()
        })
    }
}
