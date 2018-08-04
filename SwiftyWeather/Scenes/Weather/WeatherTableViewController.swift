//
//  WeatherTableViewController.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

protocol  WeatherTableViewControllerDelegate: class{
    func weatherTableViewControllerDidRefresh(_ viewController: WeatherTableViewController)
}

class WeatherTableViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!

    weak var delegate: WeatherTableViewControllerDelegate?
    lazy var refreshControl = makeRefreshControl()
    private let configurator = WeatherTableViewConfigurator()
    private var viewType = ViewType.main
    private var data: HomeViewModel?{
        didSet{
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 10
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        if viewType == ViewType.main{
            tableView.addSubview(refreshControl)
        }
    }
    
    func loadWith(data: HomeViewModel){
        self.data = data
    }
    
    private func makeRefreshControl() -> UIRefreshControl{
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_ :)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        delegate?.weatherTableViewControllerDidRefresh(self)
    }
}


extension WeatherTableViewController {
    enum ViewType {
        case main, detail
    }
    
    func setView(type: ViewType){
        self.viewType = type
    }
}


extension WeatherTableViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewType {
        case .detail:
            return 1
        case .main:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewType == ViewType.main && section==0 {
            return 0
        }
        return data?.hourlyData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { fatalError("Data not found!")}
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherDataTableViewCell.self), for: indexPath) as? WeatherDataTableViewCell else { fatalError("Cell not found!")}
        configurator.configure(cell, forDisplaying: data.hourlyData[indexPath.row], indextPath: indexPath)
        return cell
        
    }
    
}


extension WeatherTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = data else {
            let emptyView = UIView(frame: .zero)
            emptyView.backgroundColor = .clear
            return emptyView
        }
        
        switch viewType {
        case .main:
            switch section {
            case 0 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherHeaderTableViewCell.self)) as? WeatherHeaderTableViewCell else { fatalError("Cell not found!")}
                configurator.configure(cell, forDisplaying: data)
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherSectionHeaderTableViewCell.self)) as? WeatherSectionHeaderTableViewCell else { fatalError("Cell not found!")}
                configurator.configure(cell, forDisplaying: data)
                return cell
            default:
                return nil
            }
        case .detail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherSectionHeaderTableViewCell.self)) as? WeatherSectionHeaderTableViewCell else { fatalError("Cell not found!")}
            configurator.configure(cell, forDisplaying: data)
            return cell
        }

       
        
    }
}
