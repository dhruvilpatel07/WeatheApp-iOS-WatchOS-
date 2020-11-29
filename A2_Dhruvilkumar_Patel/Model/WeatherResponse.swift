//
//  WeatherResponse.swift
//  A2_Dhruvilkumar_Patel
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import Foundation

/// Main class which is mapped by API calls
struct WeatherResponse: Codable {
    let coord: WeatherCoord
    let weather: [WeatherInfo]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: WeatherWind
    let clouds: WeatherCloud
    let dt: Int
    let sys: WeatherSys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
}
