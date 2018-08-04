//
//  SearchHistoryTableViewConfigurator.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

struct SearchHistoryTableViewConfigurator {
    func configure(_ cell: SearchHistoryTableViewCell, forDisplaying data: SearchHistoryViewModel, indextPath: IndexPath) {
        cell.nameLabel.text = data.cityName
    }
}
