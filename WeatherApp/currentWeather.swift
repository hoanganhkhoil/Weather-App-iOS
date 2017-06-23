//
//  currentWeather.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/16/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import UIKit
import Alamofire

class currentWeather {
    var _date: String!
    var _currentTemp: Double!
    var _cityName: String!
    var _weather: String!
    
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = currentDate
        
        return _date
        
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        
        return _currentTemp
    }
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var weather: String {
        if _weather == nil {
            _weather = ""
        }
        
        return _weather
    }
    
    func downloadDetailsFromAPI(completed: @escaping DownloadCompleted) {
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        Alamofire.request(currentWeatherURL!).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        let kelvinToFahrenheit = (temp * 9/5 - 459.67)
                        let roundedFahrenheit = Double(round(10 * kelvinToFahrenheit/10))
                        
                        self._currentTemp = roundedFahrenheit
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let weatherType = weather[0]["main"] as? String {
                        self._weather = weatherType
                    }
                }
                
            }
            completed()
        }
        
    }
    
}
