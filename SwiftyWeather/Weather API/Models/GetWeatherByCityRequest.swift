//
//  GetWeatherByCityRequest.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct GetWeatherByCityRequest: Codable {
    let cityname: String
    var unit: TemperatureUnit = .metric
    

    init(cityName: String) {
        self.cityname = cityName
    }
    
    
    enum CodingKeys: String, CodingKey {
        case cityname = "q"
        case unit = "units"
        
    }
}
