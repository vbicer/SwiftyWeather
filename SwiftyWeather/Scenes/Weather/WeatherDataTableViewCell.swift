//
//  WeatherDataTableViewCell.swift
//  SwiftyWeather
//
//  Created by volkan biçer on 4.08.2018.
//  Copyright © 2018 volkanbicer. All rights reserved.
//

import UIKit

class WeatherDataTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }

}
