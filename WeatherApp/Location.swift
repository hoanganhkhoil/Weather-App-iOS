//
//  Location.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/17/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longtitude: Double!
    

}
