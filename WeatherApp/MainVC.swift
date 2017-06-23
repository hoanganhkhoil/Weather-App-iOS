//
//  ViewController.swift
//  WeatherApp
//
//  Created by Khoi Hoang on 4/16/17.
//  Copyright © 2017 Khoi_Entertainment. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var switchBtn: UISwitch!
    
    var currentWeatherNow: currentWeather!
    var forcast: ForeCast!
    var forecasts = [ForeCast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        locationAuthStatus()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        switchBtn.isOn = false
        
        tableView.delegate = self
        tableView.dataSource = self


        currentWeatherNow = currentWeather()
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? tableCell {
            let forecast = forecasts[indexPath.row]
            
            if switchBtn.isOn {
                cell.convertToCelcius(forecast: forecast)
            }
            
            else {
                cell.updateCell(forecast: forecast)
            }
            
            return cell
            
        }
        
        return tableCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeatherNow.date
        currentTemp.text = "\(currentWeatherNow.currentTemp)°"
        location.text = currentWeatherNow.cityName
        weather.text = currentWeatherNow.weather
        photo.image = UIImage(named: currentWeatherNow.weather)
    }
    
    func downloadForecaseData(completed: @escaping DownloadCompleted) {
        let forecastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forecastURL!).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forecast = ForeCast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
            }
            self.tableView.reloadData()
            completed()
        }
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longtitude = currentLocation.coordinate.longitude

            
            currentWeatherNow.downloadDetailsFromAPI {
                self.downloadForecaseData {
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    
    @IBAction func switchChanged(_ sender: UISwitch) {
        updateFromFahrenheitToCelcius()
        self.tableView.reloadData()
    }
    
    func updateFromFahrenheitToCelcius() {
        
        if (switchBtn.isOn) {
            
            let celciusCurrentTemp = round((currentWeatherNow.currentTemp - 32) * 5/9)
            self.currentTemp.text = "\(celciusCurrentTemp)°"
            
        }  
        
        else {
            self.currentTemp.text = "\(currentWeatherNow.currentTemp)°"
        }
    }

}

