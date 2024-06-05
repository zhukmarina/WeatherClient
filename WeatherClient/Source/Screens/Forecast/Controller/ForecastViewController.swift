import UIKit

class ForecastViewController: UIViewController {
    var cityName: String?
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
        model.loadData(for: cityName)

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
        
        forecastView.todayForecastCollectionView.backgroundColor = UIColor(red: 126/255, green: 193/255, blue: 242/255, alpha: 1.0)
        forecastView.nextWeekColectionView.backgroundColor = UIColor(red: 126/255, green: 193/255, blue: 242/255, alpha: 1.0)
        
        forecastView.todayForecastCollectionView.layer.cornerRadius = 20
        forecastView.todayForecastCollectionView.layer.masksToBounds = true

        forecastView.nextWeekColectionView.layer.cornerRadius = 20
        forecastView.nextWeekColectionView.layer.masksToBounds = true
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
    func dataDidLoad(with data: [CDWeatherInfo]) {
        self.weatherData = data 
        contentView.todayForecastCollectionView.reloadData()
        contentView.nextWeekColectionView.reloadData()

    }
    
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentView.todayForecastCollectionView {
                   
                   return min(5, weatherData.count - 1)
               } else {
                   
                   return (weatherData.count - 1) / 8
               }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if collectionView == contentView.todayForecastCollectionView {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayForecastCell", for: indexPath) as? TodayForecastCell else {
                   assertionFailure()
                   return UICollectionViewCell()
               }

               let safeIndex = indexPath.item + 1
               if safeIndex < weatherData.count {
                   let forecast = weatherData[safeIndex]
                   let temperature = WeatherUtils.convertToCelsius(kelvin: forecast.temperature)
                   let time = WeatherUtils.formatTime(from: forecast.dt)
                   let weatherDetails = forecast.weatherDetails as? Set<CDWeatherDetails>

                   cell.configure(time: time, temperature: temperature, weatherDetails: weatherDetails)
               } else {
                   print("Error: safeIndex is out of bounds: \(safeIndex)")
               }
               return cell
           } else {
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextWeekForecastCell", for: indexPath) as? NextWeekForecastCell else {
                   assertionFailure()
                   return UICollectionViewCell()
               }

               let safeIndex = (indexPath.item * 8)
               if safeIndex + 1 < weatherData.count {
                   let forecast = weatherData[safeIndex + 1]
                   let temperature = WeatherUtils.convertToCelsius(kelvin: forecast.temperature)
                   let date = WeatherUtils.formatDayAndDate(from: forecast.dt)
                   let weatherDetails = forecast.weatherDetails as? Set<CDWeatherDetails>

                   cell.configure(date: date, temperature: temperature, weatherDetails: weatherDetails)
               } else {
                   print("Error: safeIndex is out of bounds: \(safeIndex)")
               }
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
