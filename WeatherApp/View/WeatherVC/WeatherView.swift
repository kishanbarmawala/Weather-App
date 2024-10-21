//
//  WeatherView.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 20/10/24.
//

import UIKit

class LocationWeatherView: UIView {
    
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let minMaxLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let forecastCollectionView: UICollectionView
    private let cellHeight: CGFloat = 100
    private let stackView = UIStackView()
    let pressureView = DetailView()
    let humidityView = DetailView()
    let visiblityView = DetailView()

    var forecasts: [List] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        forecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = UIColor.white.withAlphaComponent(0.4)
        layer.cornerRadius = 8
        temperatureLabel.font = UIFont.systemFont(ofSize: 18)
        minMaxLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        
        weatherIcon.contentMode = .scaleAspectFit
        forecastCollectionView.showsHorizontalScrollIndicator = false
        forecastCollectionView.backgroundColor = .clear
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(ForecastItemCell.self, forCellWithReuseIdentifier: "ForecastItemCell")
        
        [cityLabel, temperatureLabel, descriptionLabel, minMaxLabel, weatherIcon, stackView, forecastCollectionView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            minMaxLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            minMaxLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            weatherIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            weatherIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weatherIcon.heightAnchor.constraint(equalToConstant: 70),
            weatherIcon.widthAnchor.constraint(equalToConstant: 70),
            
            forecastCollectionView.topAnchor.constraint(equalTo: minMaxLabel.bottomAnchor, constant: 16),
            forecastCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            forecastCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            forecastCollectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            
            stackView.topAnchor.constraint(equalTo: forecastCollectionView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        stackView.removeAllSubviews()
        stackView.addArrangedSubview(pressureView)
        stackView.addArrangedSubview(visiblityView)
        stackView.addArrangedSubview(humidityView)
    }
    
    func configure(with weatherData: WeatherData, city: City) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let tomorrowString = dateFormatter.string(from: tomorrow)
        
        if weatherData.date == currentDateString {
            cityLabel.text = "Today"
            cityLabel.font = UIFont.systemFont(ofSize: 28)
        } else if weatherData.date == tomorrowString {
            cityLabel.text = "Tomorrow"
        } else {
            cityLabel.text = weatherData.date.changeDateFormat("yyyy-MM-dd", output: "EEEE, MMM d, yyyy")
        }
        
        if let temp = weatherData.data?.first?.main?.temp {
            let finalTemp = Int(temp - 273.15)
            temperatureLabel.text = "\(finalTemp)° C"
        }
        
        descriptionLabel.text = "\(weatherData.data?.first?.weather?.first?.description?.capitalized ?? "")\n\n\(city.name ?? "")"
        
        if let max = weatherData.data?.first?.main?.tempMax?.kelvinToCelcius,
           let min = weatherData.data?.first?.main?.tempMin?.kelvinToCelcius,
           let feels = weatherData.data?.first?.main?.feelsLike?.kelvinToCelcius {
            minMaxLabel.text = "\(max) / \(min) Feels like \(feels)"
        }
        
        let pressure = Double(weatherData.data?.first?.main?.pressure ?? 0)
        let pressureInMmHg = pressure * 0.75006
        let pressureDisplay = String(format: "%.1f mmHg", pressureInMmHg)
        pressureView.configure(topValue: "Pressure", bottomValue: pressureDisplay)
        
        let visibilityInMeters = Double(weatherData.data?.first?.visibility ?? 0)
        let visibilityInKm = visibilityInMeters / 1000.0
        let visibilityDisplay = String(format: "%.1f km", visibilityInKm)
        visiblityView.configure(topValue: "Visiblity", bottomValue: visibilityDisplay)
        
        
        let humidityDisplay = "\(weatherData.data?.first?.main?.humidity ?? 0)%"
        humidityView.configure(topValue: "Humidity", bottomValue: humidityDisplay)
        
        forecasts = weatherData.data ?? []
        forecastCollectionView.reloadData()
        
        if let icon = weatherData.data?.first?.weather?.first?.icon {
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
            if let url = iconURL {
                URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                    guard let self = self, let data = data else { return }
                    DispatchQueue.main.async {
                        self.weatherIcon.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
}

extension LocationWeatherView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastItemCell", for: indexPath) as! ForecastItemCell
        cell.configure(with: forecasts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
}
