//
//  WeatherTableViewConfigurator.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct WeatherTableViewConfigurator {
    func configure(_ cell: WeatherHeaderTableViewCell, forDisplaying data: HomeViewModel) {
        cell.descriptionLabel.text = data.description
        cell.cityNameLabel.text = data.cityName
        cell.tempLabel.text = data.temp
    }
    
    func configure(_ cell: WeatherSectionHeaderTableViewCell, forDisplaying data: HomeViewModel) {
        cell.dateLabel.text = data.nameOftheDay
    }
    
    func configure(_ cell: WeatherDataTableViewCell, forDisplaying data: HomeViewModel.HourlyData, indextPath: IndexPath) {
        cell.timeLabel.text = data.date
        cell.tempLabel.text = data.temp
        cell.descriptionLabel.text = data.description
    }
}
