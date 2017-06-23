//
//  ForeCast.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/17/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import UIKit
import Alamofire

class ForeCast {
    var _date: String!
    var _weather: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weather: String {
        if _weather == nil {
            _weather = ""
        }
        
        return _weather
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0
        }
        
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0
        }
        
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToFahrenheit = (min * 9/5 - 459.67)
                let roundedFahrenheit = Double(round(10 * kelvinToFahrenheit/10))
                
                self._lowTemp = roundedFahrenheit
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToFahrenheit = (max * 9/5 - 459.67)
                let roundedFahrenheit = Double(round(10 * kelvinToFahrenheit/10))
                
                self._highTemp = roundedFahrenheit
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                
                self._weather = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let dateConvertedFromSeconds = Date(timeIntervalSince1970: date)
            
            self._date = dateConvertedFromSeconds.dayOfTheWeek()
        }
    }
    
    
}

extension Date {
        
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
