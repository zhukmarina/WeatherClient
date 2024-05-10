//
//  MainView.swift
//  WeatherClient
//
//  Created by Marina Zhukova on 09.05.2024.
//

import UIKit

class MainView: UIView{
    
    weak var delegate: MainViewDelegate?
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .red
        label.textColor = .white
        label.font = .systemFont(ofSize: 54.0)
        label.textAlignment = .center
    }
    
    func setupLayout() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.labelSideOffset).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.labelSideOffset).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: Constant.labelSideOffset).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.labelSideOffset).isActive = true
    }
}

extension MainView: MainViewProtocol{
    func setupWeather(text: String) {
        label.text = text
    }
    
    
}

private enum Constant {
    
    static let labelSideOffset: CGFloat = 30.0
}
