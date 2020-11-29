//
//  ViewController.swift
//  A2_Dhruvilkumar_Patel
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    let apiKey = "3a9085a2bc26b5b708ac22d66c8d2daf"
    var session: WCSession?
    //var city_name = ""
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var city_search_bar: UISearchBar!
    @IBOutlet weak var lbl_city_name: UILabel!
    @IBOutlet weak var lbl_city_weather_info: UILabel!
    @IBOutlet weak var lbl_city_temp: UILabel!
    @IBOutlet weak var lbl_city_high_temp: UILabel!
    @IBOutlet weak var lbl_city_low_temp: UILabel!
    @IBOutlet weak var imgView_weather_status: UIImageView!
    @IBOutlet weak var lbl_city_lat: UILabel!
    @IBOutlet weak var lbl_city_lon: UILabel!
    
    
    struct WeatherTypeList {
        static let clouds = ["Clouds", "cloud"]
        static let snow = ["Snow", "cloud.snow"]
        static let sunny = ["Sunny","sun.max.fill"]
        static let rainy = ["Rain", "cloud.rain"]
        static let smoky = ["Smoke", "smoke"]
    }
    var weather_img = ""
    
    var dummyInfo : WeatherResponse = WeatherResponse(coord: WeatherCoord(lon: 0.0, lat: 0.0), weather: [WeatherInfo(id: 1, main: "", description: "", icon: "")], base: "", main: WeatherMain(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 2, humidity: 1), visibility: 1, wind: WeatherWind(speed: 0.0, deg: 2), clouds: WeatherCloud(all: 1), dt: 1, sys: WeatherSys(type: 1, id: 1, country: "", sunrise: 2, sunset: 1), timezone: 1, id: 1, name: "", cod: 1) {
        didSet {
            DispatchQueue.main.async { [self] in
                let weatherType = dummyInfo.weather[0].main
                lbl_city_name.text = dummyInfo.name
                lbl_city_weather_info.text = dummyInfo.weather[0].description
                lbl_city_temp.text = String(format: "%.0f°", dummyInfo.main.temp)
                lbl_city_high_temp.text = String(format: "H: %.0f°", dummyInfo.main.temp_max)
                lbl_city_low_temp.text = String(format: "L: %.0f°", dummyInfo.main.temp_min)
                lbl_city_lat.text = String("Lat: \(dummyInfo.coord.lat)°")
                lbl_city_lon.text = String("Lon: \(dummyInfo.coord.lon)°")
                
                if weatherType == WeatherTypeList.clouds[0]{
                    weather_img = WeatherTypeList.clouds[1]
                    imgView_weather_status.image = UIImage(systemName: WeatherTypeList.clouds[1])
                }else if weatherType == WeatherTypeList.snow[0]{
                    weather_img = WeatherTypeList.snow[1]
                    imgView_weather_status.image = UIImage(systemName: WeatherTypeList.snow[1])
                }else if weatherType == WeatherTypeList.sunny[0]{
                    weather_img = WeatherTypeList.sunny[1]
                    imgView_weather_status.image = UIImage(systemName: WeatherTypeList.sunny[1])
                }else if weatherType == WeatherTypeList.rainy[0]{
                    weather_img = WeatherTypeList.rainy[1]
                    imgView_weather_status.image = UIImage(systemName: WeatherTypeList.rainy[1])
                }else if weatherType == WeatherTypeList.smoky[0]{
                    weather_img = WeatherTypeList.smoky[1]
                    imgView_weather_status.image = UIImage(systemName: WeatherTypeList.smoky[1])
                }else{
                    weather_img = "cloud.sun"
                    imgView_weather_status.image = UIImage(systemName: "cloud.sun")
                }
                
                passDataToWatch()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://api.openweathermap.org/data/2.5/weather?q=Toronto&units=metric&appid=3a9085a2bc26b5b708ac22d66c8d2daf"
        view.backgroundColor = .systemBackground
        imgView.bringSubviewToFront(city_search_bar)
        city_search_bar.autocapitalizationType = .words
        
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }else{
            print("Session not supported")
        }
        // Starting location for weather is toronto
        FetchWeatherJSON().getData(from: url) { (result) in
            self.dummyInfo = result
        }
        
        
    }
    
    
    /// Search button
    @IBAction func btnFindCityWeather(_ sender: Any) {
        
        let tmpStr = (city_search_bar.text?.replacingOccurrences(of: " ", with: "%20"))!
        let url = "http://api.openweathermap.org/data/2.5/weather?q=" + tmpStr + "&units=metric&appid=\(apiKey)"
        print(url)
        FetchWeatherJSON().getData(from: url) { [self] (result) in
            dummyInfo = result
            print(result.weather[0].main)
        }
        
        city_search_bar.text = ""
       
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    /// Passes data to watch by calling session sendMessage method
    func passDataToWatch(){
        print("IMG: \(weather_img)")
        if session!.isPaired{
            session?.sendMessage(["city_name": dummyInfo.name, "temp": dummyInfo.main.temp, "weather_img": weather_img], replyHandler: nil, errorHandler: { (err) in
                print(err.localizedDescription)
            })
        }
    }
    
}

