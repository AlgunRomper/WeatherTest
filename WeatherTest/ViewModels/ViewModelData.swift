//
//  ViewModelData.swift
//  WeatherTest
//
//  Created by Algun Romper  on 19.02.2024.
//

import Foundation
import SwiftUI

final class ViewModelData: ObservableObject {

    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Could't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Could't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
