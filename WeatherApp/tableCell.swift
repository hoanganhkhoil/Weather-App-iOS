//
//  tableCell.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/16/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import UIKit

class tableCell: UITableViewCell {

    @IBOutlet weak var photoSmall: UIImageView!
    @IBOutlet weak var dateSmall: UILabel!
    @IBOutlet weak var weatherSmall: UILabel!
    @IBOutlet weak var highTempSmall: UILabel!
    @IBOutlet weak var lowTempSmall: UILabel!
    
    func updateCell(forecast: ForeCast) {
        
        dateSmall.text = forecast.date
        weatherSmall.text = forecast.weather
        highTempSmall.text = "\(forecast.highTemp)°"
        lowTempSmall.text = "\(forecast.lowTemp)°"
        photoSmall.image = UIImage(named: forecast.weather)
    }
    
    func convertToCelcius(forecast: ForeCast) {
        dateSmall.text = forecast.date
        weatherSmall.text = forecast.weather
        photoSmall.image = UIImage(named: forecast.weather)
        
        let celciusHigh = round((forecast.highTemp - 32) * 5/9)
        highTempSmall.text = "\(celciusHigh)°"
        
        let celciusLow = round((forecast.lowTemp - 32) * 5/9)
        lowTempSmall.text = "\(celciusLow)°"
        
    }
}
