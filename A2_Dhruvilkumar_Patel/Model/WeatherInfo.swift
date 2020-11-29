//
//  WeatherInfo.swift
//  A2_Dhruvilkumar_Patel
//
//  Created by Dhruvil Patel on 2020-11-25.
//

import Foundation

/// Main weather info description
struct WeatherInfo: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
