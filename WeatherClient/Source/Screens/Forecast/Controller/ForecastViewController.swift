import UIKit

class ForecastViewController: UIViewController {

    var model: ForecastModelProtocol!
    var contentView: ForecastView!
    var weatherData: [CDWeatherInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let forecastView = view as? ForecastView else {
            fatalError("Expected view to be of type ForecastView")
        }
        contentView = forecastView
        forecastView.delegate = self
        setupInitialState()
        setupUI()
        model.loadData()

        forecastView.todayForecastCollectionView.delegate = self
        forecastView.todayForecastCollectionView.dataSource = self
        forecastView.nextWeekColectionView.delegate = self
        forecastView.nextWeekColectionView.dataSource = self

        forecastView.todayForecastCollectionView.register(TodayForecastCell.self, forCellWithReuseIdentifier: "TodayForecastCell")
        forecastView.nextWeekColectionView.register(NextWeekForecastCell.self, forCellWithReuseIdentifier: "NextWeekForecastCell")

        if let todayFlowLayout = forecastView.todayForecastCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            todayFlowLayout.scrollDirection = .horizontal
        }

        if let nextWeekFlowLayout = forecastView.nextWeekColectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            nextWeekFlowLayout.scrollDirection = .vertical
        }
    }

    private func setupInitialState() {
        let forecastModel = ForecastModel(delegate: self)
        model = forecastModel
    }

    private func setupUI() {
        let gradientView = GradientView()
        gradientView.startColor = UIColor(red: 71/255, green: 191/255, blue: 223/255, alpha: 1.0)
        gradientView.endColor = UIColor(red: 74/255, green: 145/255, blue: 255/255, alpha: 1.0)
        gradientView.startPoint = CGPoint(x: 0, y: 0)
        gradientView.endPoint = CGPoint(x: 1, y: 1)
        gradientView.frame = view.bounds
        view.insertSubview(gradientView, at: 0)
    }
}

extension ForecastViewController: ForecastViewDelegate {
    // Реалізація методів делегата, якщо вони є
}

extension ForecastViewController: ForecastModelDelegate {
    func dataDidLoad(with data: [CDWeatherInfo]) { // Оновлено параметр
        self.weatherData = data // Присвоєння значення параметра weatherData
        contentView.todayForecastCollectionView.reloadData()
        contentView.nextWeekColectionView.reloadData()
//        print("Data ______________________ loaded: \(data [1...5] )")
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.todayForecastCollectionView {
            return min(5, weatherData.count)
        } else {
            return weatherData.count / 8
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.todayForecastCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayForecastCell", for: indexPath) as? TodayForecastCell else {
                assertionFailure()
                return UICollectionViewCell()
            }

            let forecast = weatherData[indexPath.item ]
            let temperature = WeatherUtils.convertToCelsius(kelvin: forecast.temperature)
            let time = WeatherUtils.formatTime(from: Int(forecast.dt))
            cell.configure(time: time, temperature: temperature, weatherIcon: UIImage(named: "sunny"))
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextWeekForecastCell", for: indexPath) as? NextWeekForecastCell else {
                assertionFailure()
                return UICollectionViewCell()
            }

            let forecast = weatherData[indexPath.item * 8]
            let temperature = WeatherUtils.convertToCelsius(kelvin: forecast.temperature)
            let date = WeatherUtils.formatDayAndDate(from: Int(forecast.dt))
            cell.configure(date: date, temperature: temperature, weatherIcon: UIImage(named: "cloudy"))
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentView.todayForecastCollectionView {
            return CGSize(width: 65, height: 200)
        } else {
            return CGSize(width: 280, height: 60)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
