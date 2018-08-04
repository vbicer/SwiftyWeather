//
//  WeatherApiTarget.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation
import Moya


enum WeatherService{
    case getWeatherByCity(data: GetWeatherByCityRequest)
}


extension WeatherService: TargetType{
    var baseURL: URL  {
        return URL(string: ApiConstants.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getWeatherByCity:
            return "/forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherByCity:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWeatherByCity(let data):
            return Task.requestParameters(parameters: DictionaryBuilder.buildWithAppId(data: data), encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}

struct DictionaryBuilder {
    static func buildWithAppId (data: Codable) -> [String: Any]{
        var dict = data.dictionary
        dict["APPID"] = ApiConstants.APP_ID
        return dict
    }
}
