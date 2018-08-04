//
//  SearchHistoryViewModel.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct SearchHistoryViewModel {
    let cityName: String
    
    init(_ cityName: String){
        self.cityName = cityName
    }
}
