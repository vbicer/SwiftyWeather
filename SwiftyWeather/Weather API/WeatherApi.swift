//
//  WeatherService.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation
import Moya

class WeatherApi{
    let provider = MoyaProvider<WeatherService>(plugins: [
            NetworkLoggerPlugin(verbose: false, cURL: true)
        ])

    func getWeather(_ data: GetWeatherByCityRequest,
                    success:@escaping (WeatherResponse) -> (),
                    error:@escaping (WeatherApiError) -> ()){
        provider.request(.getWeatherByCity(data: data), completion: {result in
            switch result{
            case .success(let response):
                switch response.statusCode{
                case 200:
                    guard let data = try? response.map(WeatherResponse.self) else {
                        error(WeatherApiError.parsingError)
                        return
                    }
                    success(data)
                case 401:
                    error(WeatherApiError.unAuthorizedError)
                case 404:
                    error(WeatherApiError.notFound)
                default:
                    error(WeatherApiError.serverError)
                }
            case .failure( _):
                error(WeatherApiError.serverError)
            }
        })
    }
}



