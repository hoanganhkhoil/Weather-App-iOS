//
//  constants.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/16/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGTITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "b93f1e935f12c14719142ce29265a212"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGTITUDE)\(Location.sharedInstance.longtitude!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longtitude!)&cnt=10&appid=b93f1e935f12c14719142ce29265a212"

typealias DownloadCompleted = () -> ()



