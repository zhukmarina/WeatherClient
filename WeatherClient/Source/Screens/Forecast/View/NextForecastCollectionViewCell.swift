import UIKit

class NextWeekForecastCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
     
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func configure(date: String, temperature: String, weatherDetails: Set<CDWeatherDetails>?) {
           
           
        
        let weatherIcon = UIImageView()
        let labelDate = UILabel()
        let labelTemp = UILabel()
        
        if let weatherDetails = weatherDetails, let iconName = weatherDetails.first?.icon, let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png") {
            weatherIcon.loadImage(from: url)
        } else {
            weatherIcon.image = nil 
        }
        
    
        labelDate.text = "\(date)"
        labelTemp.text = "\(temperature)"
        
        labelDate.textColor = .white
        labelTemp.textColor = .white
        
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDate)
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTemp)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherIcon)
       
        
        NSLayoutConstraint.activate([
            labelDate.centerXAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            labelDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelTemp.centerXAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            labelTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            

        ])
    }
}
