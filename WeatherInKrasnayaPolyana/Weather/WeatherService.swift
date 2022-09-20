//
//  WeatherService.swift
//  WeatherInKrasnayaPolyana
//
//  Created by Ян Нурков on 20.09.2022.
//

import Foundation

enum ServiceError: Error {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError)
}

struct WeatherService {
    var delegate: WeatherServiceDelegate?
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?appid=860759f3d850f86a91d1d3c1d21e686c&units=metric")!
    func fetchWeather(cityName: String) {
        guard let urlEncodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)")
            return
        }
        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let unwrapedData = data,
                  let httpResponse = response as? HTTPURLResponse
            else { return }
            guard error == nil else {
                DispatchQueue.main.async {
                    let generalError = ServiceError.general(reason: "Check network availability.")
                    self.delegate?.didFailWithError(self, generalError)
                }
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, ServiceError.network(statusCode: httpResponse.statusCode))
                }
                return
            }
            guard let weather = self.parseJSON(unwrapedData) else { return }
            
            DispatchQueue.main.async {
                self.delegate?.didFetchWeather(self, weather)
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
            DispatchQueue.main.async {
                self.delegate?.didFailWithError(self, ServiceError.parsing)
            }
            return nil
        }
        
        let id1 = decodedData.list[0].weather[0].id
        let temp1 = decodedData.list[0].main.temp
        let id2 = decodedData.list[1].weather[0].id
        let temp2 = decodedData.list[1].main.temp
        let id3 = decodedData.list[3].weather[0].id
        let temp3 = decodedData.list[3].main.temp
        let id4 = decodedData.list[4].weather[0].id
        let temp4 = decodedData.list[4].main.temp
        let id5 = decodedData.list[5].weather[0].id
        let temp5 = decodedData.list[5].main.temp
        let id6 = decodedData.list[6].weather[0].id
        let temp6 = decodedData.list[6].main.temp
        let id7 = decodedData.list[7].weather[0].id
        let temp7 = decodedData.list[7].main.temp
        let id8 = decodedData.list[8].weather[0].id
        let temp8 = decodedData.list[8].main.temp
        let id9 = decodedData.list[9].weather[0].id
        let temp9 = decodedData.list[9].main.temp
        let id10 = decodedData.list[10].weather[0].id
        let temp10 = decodedData.list[10].main.temp
        let id11 = decodedData.list[11].weather[0].id
        let temp11 = decodedData.list[11].main.temp
        let id12 = decodedData.list[12].weather[0].id
        let temp12 = decodedData.list[12].main.temp
        let id13 = decodedData.list[13].weather[0].id
        let temp13 = decodedData.list[13].main.temp
        let id14 = decodedData.list[14].weather[0].id
        let temp14 = decodedData.list[14].main.temp
        let id15 = decodedData.list[15].weather[0].id
        let temp15 = decodedData.list[15].main.temp
        let id16 = decodedData.list[16].weather[0].id
        let temp16 = decodedData.list[16].main.temp
        let id17 = decodedData.list[17].weather[0].id
        let temp17 = decodedData.list[17].main.temp
        let id18 = decodedData.list[18].weather[0].id
        let temp18 = decodedData.list[18].main.temp
        let id19 = decodedData.list[19].weather[0].id
        let temp19 = decodedData.list[19].main.temp
        let id20 = decodedData.list[20].weather[0].id
        let temp20 = decodedData.list[20].main.temp
        let id21 = decodedData.list[21].weather[0].id
        let temp21 = decodedData.list[21].main.temp
        let id22 = decodedData.list[22].weather[0].id
        let temp22 = decodedData.list[22].main.temp
        let id23 = decodedData.list[23].weather[0].id
        let temp23 = decodedData.list[23].main.temp
        let id24 = decodedData.list[24].weather[0].id
        let temp24 = decodedData.list[24].main.temp
      
        let weather = WeatherModel(conditionId1: id1, temperature1: temp1, conditionId2: id2, temperature2: temp2, conditionId3: id3, temperature3: temp3, conditionId4: id4, temperature4: temp4, conditionId5: id5, temperature5: temp5, conditionId6: id6, temperature6: temp6, conditionId7: id7, temperature7: temp7, conditionId8: id8, temperature8: temp8, conditionId9: id9, temperature9: temp9, conditionId10: id10, temperature10: temp10, conditionId11: id11, temperature11: temp11, conditionId12: id12, temperature12: temp12, conditionId13: id13, temperature13: temp13, conditionId14: id14, temperature14: temp14, conditionId15: id15, temperature15: temp15, conditionId16: id16, temperature16: temp16, conditionId17: id17, temperature17: temp17, conditionId18: id18, temperature18: temp18, conditionId19: id19, temperature19: temp19, conditionId20: id20, temperature20: temp20, conditionId21: id21, temperature21: temp21, conditionId22: id22, temperature22: temp22, conditionId23: id23, temperature23: temp23, conditionId24: id24, temperature24: temp24)
        return weather
    }
}
