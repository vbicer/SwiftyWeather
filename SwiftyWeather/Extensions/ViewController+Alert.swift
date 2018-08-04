//
//  ViewController+Alert.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

extension ViewController{
    func showAlert(_ message: String,  title: String = ""){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
