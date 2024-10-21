//
//  WeatherCollectionViewCell.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 19/10/24.
//

import UIKit

class ForecastItemCell: UICollectionViewCell {
    
    private let dateLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = UIColor.white.withAlphaComponent(0.6)
        layer.cornerRadius = 8.0
        
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        [dateLabel, temperatureLabel, descriptionLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -12)
        ])
        
    }
    
    func configure(with forecast: List) {
        dateLabel.text = forecast.dtTxt.changeDateFormat("yyyy-MM-dd HH:mm:ss", output: "h:mm a")
        temperatureLabel.text = forecast.main?.temp?.kelvinToCelcius
        descriptionLabel.text = forecast.weather?.first?.main
    }
    
}
