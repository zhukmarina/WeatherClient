import UIKit

class NextWeekForecastCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
      
        let label = UILabel()
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(date: String, temperature: String, weatherIcon: UIImage?) {
        let icon = UIImage()
        let labelDate = UILabel()
        let labelTemp = UILabel()
        
        
        labelDate.text = "\(date)"
        labelTemp.text = "\(temperature)"
        
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelDate)
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTemp)
       
        
        NSLayoutConstraint.activate([
            labelDate.centerXAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            labelDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelTemp.centerXAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            labelTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            

        ])
    }
}
