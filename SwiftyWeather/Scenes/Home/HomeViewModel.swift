//
//  HomeViewModel.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct HomeViewModel {
    let cityName: String
    let temp: String
    let description: String
    let hourlyData: [HourlyData]
    let nameOftheDay: String
    
    
    
    struct HourlyData {
        let date: String
        let temp: String
        let description: String
    }
}


extension HomeViewModel {

    static func createViewModel(_ response: WeatherResponse) -> [HomeViewModel]{
        var list = [HomeViewModel]()
        let cityName = "\(response.city.name), \(response.city.country)"
        let dict = Dictionary(grouping: response.list) { (item) -> String in
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            return date.nameOfTheDay
        }
        
        var today = Date()
        for _ in 0..<dict.count{
            today = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            guard let data = dict[today.nameOfTheDay] else { continue }
            let viewModel = HomeViewModel(data, cityName: cityName)
            list.append(viewModel)
        }
        
        return list
    }
    
    init(_ data: [List], cityName: String) {
        self.cityName = cityName
        guard let currentData = data.first else {  fatalError("Response empty") }
        temp = "\(Int(currentData.main.temp))℃"
        description = currentData.weather.first?.main ?? ""
        nameOftheDay = Date(timeIntervalSince1970: TimeInterval(currentData.dt)).nameOfTheDay
        var hourly = [HourlyData]()
        
        for data in data where hourly.count<8{
            let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
            let dataTemp = "\(Int(data.main.temp))℃"
            hourly.append(HourlyData(date: date.hourWithMinute, temp: dataTemp, description: data.weather.first?.main ?? ""))            
        }
        hourlyData = hourly
    }
    
    init(_ response: WeatherResponse) {
        cityName = "\(response.city.name), \(response.city.country)"
        guard let currentData = response.list.first else {  fatalError("Response empty") }
        temp = "\(Int(currentData.main.temp))℃"
        description = currentData.weather.first?.main ?? ""
        nameOftheDay = Date(timeIntervalSince1970: TimeInterval(currentData.dt)).nameOfTheDay
        var hourly = [HourlyData]()
        
        for data in response.list where hourly.count<8{
            let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
            let dataTemp = "\(Int(data.main.temp))℃"
            hourly.append(HourlyData(date: date.hourWithMinute, temp: dataTemp, description: data.weather.first?.main ?? ""))
        }
        hourlyData = hourly
    }
}





