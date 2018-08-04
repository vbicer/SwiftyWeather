//
//  WeatherDetailViewController.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var weatherContainerView: UIView!

    private lazy var weatherViewController = makeWeatherViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
        add(asChildViewController: weatherViewController, containerView: weatherContainerView)
    }
    
    private func makeWeatherViewController() -> WeatherTableViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: WeatherTableViewController.self)) as! WeatherTableViewController
        controller.setView(type: .detail)
        return controller
    }
    
    @IBAction func didTapDismissButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func loadWith(_ data: HomeViewModel){
        weatherViewController.loadWith(data: data)
    }
}
