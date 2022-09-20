//
//  WeatherData.swift
//  WeatherInKrasnayaPolyana
//
//  Created by Ян Нурков on 20.09.2022.
//

import Foundation


struct WeatherData: Codable {
    let list: [List]
    let city: City
}

struct City: Codable {
    let name: String
    let timezone: Int
}

struct List: Codable {
    let main: MainClass
    let weather: [Weather]
}


struct Weather: Codable {
    let description: String
    let id: Int
}

struct MainClass: Codable {
    let temp: Double
}
