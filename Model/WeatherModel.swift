//
//  WeatherModel.swift
//  Clima
//
//  Created by Caio Serpa on 02/01/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String(format: "%.0f", temperature - 273.15)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    }
    

