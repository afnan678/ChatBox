//
//  Countries.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import Foundation
public class Countries {
    private var countries = [Country]()  // Fix 1: Initialize as an array of Country
    
    public init() {
        self.countries = loadCountriesFromJson()
    }

    private func loadCountriesFromJson() -> [Country] {
        var countries = [Country]()
        
        guard let jsonPath = Bundle.main.path(forResource: "countries", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
                return countries
        }
        
        let translation = JSONTranslation()
        do {
            let objects: [Country] = try translation.parseJSON(data: jsonData)  // Fix 2: Use parseJSON method
            countries = objects
        } catch {
            print("Error parsing JSON: \(error)")
        }
        return countries
    }

    public var allCountries: [Country] {
        return countries
    }
}
