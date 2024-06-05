//
// GradientView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 17.05.2024.
//

import UIKit

class GradientView: UIView {
    var startColor: UIColor = .white
    var endColor: UIColor = .black
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    var endPoint: CGPoint = CGPoint(x: 1, y: 1)

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)!

        let startPoint = CGPoint(x: self.startPoint.x * rect.width, y: self.startPoint.y * rect.height)
        let endPoint = CGPoint(x: self.endPoint.x * rect.width, y: self.endPoint.y * rect.height)

        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
