//
//  WeatherManager.swift
//  Clima
//
//  Created by Caio Serpa on 13/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func  didUpdateWeather(_ WeatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlstring = "\(weatherURL)q=\(cityName)&appid=a3f8d117abb0ba0888ceb11b0943d2b5"
        performRequest(with: urlstring)
        
    }
    func fetchWeather(latitute: CLLocationDegrees, longitute: CLLocationDegrees ){
        let urlString = "\(weatherURL)&lat=\(latitute)&lon=\(longitute)&appid=a3f8d117abb0ba0888ceb11b0943d2b5"
        performRequest(with:  urlString)
        
    }
    
    func performRequest(with urlstring: String){
        
        //1. criar url
        if let url = URL(string: urlstring) {
           // print(urlstring)
            //print(url)
            
            //2. criar urlsesion
            
            let session = URLSession(configuration: .default)
            //print(session)
            
            //3.dar uma tarefa de sessão
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                  //  print("printando safedata: \(safeData)")
                    if let weather = self.parseJSON(safeData)  {
                        //print(weather)
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.iniciar a tarefa
            //print(task)
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
 
}
