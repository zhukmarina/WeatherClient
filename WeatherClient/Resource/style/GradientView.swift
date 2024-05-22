//
// GradientView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 17.05.2024.
//

import UIKit

class GradientView: UIView {
    var startColor: UIColor = .clear
    var endColor: UIColor = .clear
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = CGPoint(x: 1, y: 1)

    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
