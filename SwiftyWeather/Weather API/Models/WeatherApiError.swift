//
//  WeatherApiError.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation


enum WeatherApiError: Error{
    case notFound
    case serverError
    case parsingError
    case unAuthorizedError
}


extension WeatherApiError {
    var message: String{
        switch self {
        case .notFound:
            return "City not found"
        case .unAuthorizedError:
            return "Please provide valid AppID!"
        default:
            return "Something went wrong"
        }
    }
}
