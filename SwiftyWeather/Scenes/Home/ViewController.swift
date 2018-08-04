//
//  ViewController.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let weatherApi = WeatherApi()
    private let historyService = SearchHistoryService()
    private lazy var historyViewController = makeHistoryViewController()
    private lazy var weatherViewController = makeWeatherViewController()
    private var sheetData = [HomeViewModel]()
    var currentCityName: String =  "İstanbul"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var historyContainerView: UIView!
    @IBOutlet weak var weatherContainerView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        add(asChildViewController: weatherViewController, containerView: weatherContainerView)
        getWeatherData(currentCityName)
    }
    
    private func setupViews(){
        addGradientBackground()
        addTapGuestureToView()
        searchBar.delegate = self
        historyContainerView.layer.cornerRadius = 10.0
        historyContainerView.layer.masksToBounds = true
    }
    
    private func addTapGuestureToView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewDidTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func viewDidTap(_ sender: UITapGestureRecognizer){
        searchBar.resignFirstResponder()
        toggleHistoryView(false)
    }
    
    private func makeHistoryViewController() -> SearchHistoryTableViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: SearchHistoryTableViewController.self)) as! SearchHistoryTableViewController
        controller.delegate = self
        return controller
    }
    
    private func makeWeatherViewController() -> WeatherTableViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: WeatherTableViewController.self)) as! WeatherTableViewController
        controller.delegate = self
        return controller
    }
    
    private func makeWeatherDetailViewController() -> WeatherDetailViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: WeatherDetailViewController.self)) as! WeatherDetailViewController
        return controller
    }
    
    func getWeatherData(_ cityName: String){
        weatherApi.getWeather(GetWeatherByCityRequest(cityName: cityName),
                              success: { [weak self](data) in
            self?.currentCityName = cityName
            self?.historyService.addToHistory(cityName)
            let model = HomeViewModel(data)
            self?.weatherViewController.loadWith(data: model)
            self?.sheetData = HomeViewModel.createViewModel(data)
        },
                              error: { [weak self] err in
            self?.showAlert(err.message)
        })
    }
    
    func processSearch(_ cityName: String){
        toggleHistoryView(false)
        getWeatherData(cityName)
        searchBar.resignFirstResponder()
    }

    func toggleHistoryView(_ show: Bool){
        if show && !historyService.isHistoryEmpty(){
            historyContainerView.isHidden = false
            add(asChildViewController: historyViewController, containerView: historyContainerView)
        }else if !show{
            historyContainerView.isHidden = true
            remove(asChildViewController: historyViewController)
        }
    }
    
    @IBAction func didTapMoreButton(_ sender: UIButton){
        if sheetData.isEmpty { return }
        let actionSheet = UIAlertController(title: "Change The Day", message: "", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        for model in sheetData{
            let action = UIAlertAction(title: model.nameOftheDay, style: .default) { (ac) in
                let vc = self.makeWeatherDetailViewController()
                _ = vc.view
                vc.modalPresentationStyle = .overCurrentContext
                vc.loadWith(model)
                self.present(vc, animated: true, completion: nil)
            }
            actionSheet.addAction(action)
        }
        present(actionSheet, animated: true, completion: nil)
    }
}










