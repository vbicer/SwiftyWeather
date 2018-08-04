//
//  ViewController+Extensions.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 3.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func add(asChildViewController viewController: UIViewController, containerView: UIView) {        
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    func addGradientBackground(){
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [
            UIColor(red:1.00, green:0.65, blue:0.62, alpha:1.0).cgColor,
            UIColor(red:0.53, green:0.09, blue:0.34, alpha:0.7).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
