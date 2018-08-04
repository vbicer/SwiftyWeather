//
//  WeatherResponse.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//


import Foundation

struct WeatherResponse: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
}

struct Coord: Codable {
    let lon, lat: Double
}

struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
    }
}

struct Clouds: Codable {
    let all: Int
}

struct Main: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Sys: Codable {
    let pod: String
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed, deg: Double
}
