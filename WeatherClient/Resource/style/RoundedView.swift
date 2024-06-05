//
//  RoundedView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 17.05.2024.
//

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20 
        layer.masksToBounds = true
    }
}
