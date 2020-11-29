//
//  WeatherSys.swift
//  A2_Dhruvilkumar_Patel
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import Foundation

/// city info 
struct WeatherSys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
