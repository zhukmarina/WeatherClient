import UIKit

class TodayForecastCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    func configure(time: String, temperature: String, weatherDetails: Set<CDWeatherDetails>?) {
        let weatherIcon = UIImageView()

                if let weatherDetails = weatherDetails, let iconName = weatherDetails.first?.icon, let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png") {
                    weatherIcon.loadImage(from: url)
                } else {
                    weatherIcon.image = nil
                }
            

        let labelTime = UILabel()
        let labelTemp = UILabel()
    
    labelTime.text = "\(time)"
        labelTemp.text = "\(temperature)"
        labelTime.textColor = .white
        labelTemp.textColor = .white
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTime)
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTemp)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            labelTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labelTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          
        ])    }
}

