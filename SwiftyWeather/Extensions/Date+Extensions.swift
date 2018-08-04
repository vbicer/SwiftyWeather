//
//  Date+Extensions.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

extension Date{
    var nameOfTheDay: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return  formatter.string(from: self)
    }
    
    var hourWithMinute: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
