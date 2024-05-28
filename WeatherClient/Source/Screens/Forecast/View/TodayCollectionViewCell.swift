import UIKit

class TodayForecastCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        // Для перевірки
        let label = UILabel()
        label.text = "Test"
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(time: String, temperature: String, weatherIcon: UIImage?) {

        let labelTime = UILabel()
        let labelTemp = UILabel()
        labelTime.text = "\(time)"
        labelTemp.text = "\(temperature)"
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTime)
        labelTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTemp)
        
        
        NSLayoutConstraint.activate([
            labelTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labelTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0) 
        ])    }
}
