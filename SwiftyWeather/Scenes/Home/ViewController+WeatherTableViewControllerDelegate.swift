//
//  ViewController+WeatherTableViewControllerDelegate.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

extension ViewController: WeatherTableViewControllerDelegate{
    func weatherTableViewControllerDidRefresh(_ viewController: WeatherTableViewController) {
        getWeatherData(currentCityName)
    }
}
