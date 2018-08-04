//
//  ViewController+SearchHistoryTableViewControllerDelegate.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import Foundation

extension ViewController: SearchHistoryTableViewControllerDelegate{
    func searchHistoryTableViewController(_ viewController: SearchHistoryTableViewController, didSelect city: String) {
        searchBar.text = city
        processSearch(city)
    }
}
