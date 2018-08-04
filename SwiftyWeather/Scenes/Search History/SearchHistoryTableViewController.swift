//
//  SearchHistoryTableViewController.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

protocol SearchHistoryTableViewControllerDelegate: class {
    func searchHistoryTableViewController(_ viewController: SearchHistoryTableViewController, didSelect city: String)
}

class SearchHistoryTableViewController: UITableViewController {

    weak var delegate: SearchHistoryTableViewControllerDelegate?
    private let configurator = SearchHistoryTableViewConfigurator()
    private var data: [SearchHistoryViewModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    private let searchHistoryService = SearchHistoryService()
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = searchHistoryService.getHistory().map({cityname in
            return SearchHistoryViewModel(cityname)
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchHistoryTableViewCell.self), for: indexPath) as? SearchHistoryTableViewCell else {
            fatalError("Cell not found")
        }
        configurator.configure(cell, forDisplaying: data[indexPath.row], indextPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchHistoryTableViewController(self, didSelect: data[indexPath.row].cityName)
    }
    
}



