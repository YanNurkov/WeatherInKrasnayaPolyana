//
//  WeatherModel.swift
//  WeatherInKrasnayaPolyana
//
//  Created by Ян Нурков on 20.09.2022.
//

import Foundation
struct WeatherModel {
    
    let conditionId1: Int
    let temperature1: Double
    let conditionId2: Int
    let temperature2: Double
    let conditionId3: Int
    let temperature3: Double
    let conditionId4: Int
    let temperature4: Double
    let conditionId5: Int
    let temperature5: Double
    let conditionId6: Int
    let temperature6: Double
    let conditionId7: Int
    let temperature7: Double
    let conditionId8: Int
    let temperature8: Double
    let conditionId9: Int
    let temperature9: Double
    let conditionId10: Int
    let temperature10: Double
    let conditionId11: Int
    let temperature11: Double
    let conditionId12: Int
    let temperature12: Double
    let conditionId13: Int
    let temperature13: Double
    let conditionId14: Int
    let temperature14: Double
    let conditionId15: Int
    let temperature15: Double
    let conditionId16: Int
    let temperature16: Double
    let conditionId17: Int
    let temperature17: Double
    let conditionId18: Int
    let temperature18: Double
    let conditionId19: Int
    let temperature19: Double
    let conditionId20: Int
    let temperature20: Double
    let conditionId21: Int
    let temperature21: Double
    let conditionId22: Int
    let temperature22: Double
    let conditionId23: Int
    let temperature23: Double
    let conditionId24: Int
    let temperature24: Double
    
    
    var temperatureTomorrow: String {
        var averageTemperatureTomorrow = [Double]()
        averageTemperatureTomorrow.append(temperature9)
        averageTemperatureTomorrow.append(temperature10)
        averageTemperatureTomorrow.append(temperature11)
        averageTemperatureTomorrow.append(temperature12)
        averageTemperatureTomorrow.append(temperature13)
        averageTemperatureTomorrow.append(temperature14)
        averageTemperatureTomorrow.append(temperature15)
        averageTemperatureTomorrow.append(temperature16)
        guard let max = averageTemperatureTomorrow.max() else {return ""}
        return String(format: "%.0f", max)
    }
    
    
    var temperatureAfterTomorrow: String {
        var averageTemperatureTomorrow = [Double]()
        averageTemperatureTomorrow.append(temperature17)
        averageTemperatureTomorrow.append(temperature18)
        averageTemperatureTomorrow.append(temperature19)
        averageTemperatureTomorrow.append(temperature20)
        averageTemperatureTomorrow.append(temperature21)
        averageTemperatureTomorrow.append(temperature22)
        averageTemperatureTomorrow.append(temperature23)
        averageTemperatureTomorrow.append(temperature24)
        guard let max = averageTemperatureTomorrow.max() else {return ""}
        return String(format: "%.0f", max)
    }
    
    var temperatureString1: String {
        return String(format: "%.0f", temperature1)
    }
    
    var conditionName1: String {
        switch conditionId1 {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var conditionNameTomorrow: String {
        switch conditionId13 {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var conditionNameAfterTomorrow: String {
        switch conditionId20 {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
