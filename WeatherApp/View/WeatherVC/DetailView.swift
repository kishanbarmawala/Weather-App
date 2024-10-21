//
//  DetailView.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 20/10/24.
//

import UIKit

class DetailView: UIView {
    
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = UIColor.white.withAlphaComponent(0.45)
        layer.cornerRadius = 8
        
        topLabel.font = UIFont.systemFont(ofSize: 14)
        topLabel.textAlignment = .center
        bottomLabel.font = UIFont.systemFont(ofSize: 14)
        bottomLabel.textAlignment = .center
        bottomLabel.adjustsFontSizeToFitWidth = true
        bottomLabel.minimumScaleFactor = 0.4
        
        [topLabel, bottomLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
    }
    
    func configure(topValue: String, bottomValue: String) {
        topLabel.text = topValue
        bottomLabel.text = bottomValue
    }
    
}
