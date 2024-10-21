//
//  WeatherBackgroundManager.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 20/10/24.
//

import UIKit

class WeatherChanger {
    private var weatherLayer: CAGradientLayer?
    private var rainLayer: CAEmitterLayer?
    private var snowLayer: CAEmitterLayer?
    private var mistLayer: CAEmitterLayer?
    private var starsLayer: CAEmitterLayer?
    private weak var targetView: UIView?
    
    init(view: UIView) {
        self.targetView = view
    }
    
    func setupWeatherBackground(for weather: String, city: City) {

        weatherLayer?.removeFromSuperlayer()
        rainLayer?.removeFromSuperlayer()
        snowLayer?.removeFromSuperlayer()
        mistLayer?.removeFromSuperlayer()
        starsLayer?.removeFromSuperlayer()
        
        weatherLayer = CAGradientLayer()
        weatherLayer?.frame = targetView?.bounds ?? .zero
        weatherLayer?.startPoint = CGPoint(x: 0.5, y: 0)
        weatherLayer?.endPoint = CGPoint(x: 0.5, y: 1)
        
        let isNight = Date() > Date(timeIntervalSince1970: TimeInterval(city.sunset ?? 0))
        
        switch weather {
            case _ where weather.contains("clear"):
                if isNight {
                    weatherLayer?.colors = [
                        UIColor(red: 45/255, green: 50/255, blue: 72/255, alpha: 1.0).cgColor,
                        UIColor(red: 29/255, green: 34/255, blue: 45/255, alpha: 1.0).cgColor
                    ]
                    addStarsOverlay()
                } else {
                    weatherLayer?.colors = [
                        UIColor(red: 135/255, green: 206/255, blue: 250/255, alpha: 1.0).cgColor,
                        UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0).cgColor
                    ]
                }
            case _ where weather.contains("clouds"):
                if isNight {
                    weatherLayer?.colors = [
                        UIColor(red: 45/255, green: 50/255, blue: 72/255, alpha: 1.0).cgColor,
                        UIColor(red: 29/255, green: 34/255, blue: 45/255, alpha: 1.0).cgColor
                    ]
                    addStarsOverlay()
                } else {
                    weatherLayer?.colors = [
                        UIColor.systemYellow.withAlphaComponent(0.6).cgColor,
                        UIColor.systemTeal.withAlphaComponent(0.4).cgColor
                    ]
                }
            case _ where weather.contains("rain"):
                if isNight {
                    weatherLayer?.colors = [
                        UIColor(red: 45/255, green: 50/255, blue: 72/255, alpha: 1.0).cgColor,
                        UIColor(red: 29/255, green: 34/255, blue: 45/255, alpha: 1.0).cgColor
                    ]
                    addStarsOverlay()
                } else {
                    weatherLayer?.colors = [
                        UIColor.systemBlue.withAlphaComponent(0.6).cgColor,
                        UIColor.cyan.withAlphaComponent(0.4).cgColor
                    ]
                }
                addRainAnimation()
            case _ where weather.contains("snow"):
                if isNight {
                    weatherLayer?.colors = [
                        UIColor(red: 45/255, green: 50/255, blue: 72/255, alpha: 1.0).cgColor,
                        UIColor(red: 29/255, green: 34/255, blue: 45/255, alpha: 1.0).cgColor
                    ]
                    addStarsOverlay()
                } else {
                    weatherLayer?.colors = [
                        UIColor.white.withAlphaComponent(0.8).cgColor,
                        UIColor.lightGray.withAlphaComponent(0.6).cgColor
                    ]
                }
                addSnowAnimation()
            case _ where weather.contains("mist"):
                if isNight {
                    weatherLayer?.colors = [
                        UIColor(red: 45/255, green: 50/255, blue: 72/255, alpha: 1.0).cgColor,
                        UIColor(red: 29/255, green: 34/255, blue: 45/255, alpha: 1.0).cgColor
                    ]
                    addStarsOverlay()
                } else {
                    weatherLayer?.colors = [
                        UIColor.lightGray.withAlphaComponent(0.7).cgColor,
                        UIColor.gray.withAlphaComponent(0.4).cgColor
                    ]
                }
                addMistAnimation()
            default:
                weatherLayer?.colors = [
                    UIColor.white.withAlphaComponent(0.9).cgColor,
                    UIColor.lightGray.withAlphaComponent(0.4).cgColor
                ]
        }
        
        if let weatherLayer = weatherLayer {
            targetView?.layer.insertSublayer(weatherLayer, at: 0)
        }
    }
    
    private func addRainAnimation() {
        rainLayer = CAEmitterLayer()
        rainLayer?.emitterPosition = CGPoint(x: targetView?.bounds.width ?? 0 / 2, y: -10)
        rainLayer?.emitterShape = .line
        rainLayer?.emitterSize = CGSize(width: targetView?.bounds.width ?? 0, height: 1)
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(systemName: "drop.fill")?.cgImage
        rainCell.scale = 0.1
        rainCell.birthRate = 20
        rainCell.lifetime = 5.0
        rainCell.velocity = 200
        rainCell.emissionLongitude = .pi
        
        rainLayer?.emitterCells = [rainCell]
        if let rainLayer = rainLayer {
            targetView?.layer.addSublayer(rainLayer)
        }
    }
    
    private func addSnowAnimation() {
        snowLayer = CAEmitterLayer()
        snowLayer?.emitterPosition = CGPoint(x: targetView?.bounds.width ?? 0 / 2, y: -10)
        snowLayer?.emitterShape = .line
        snowLayer?.emitterSize = CGSize(width: targetView?.bounds.width ?? 0, height: 1)
        
        let snowCell = CAEmitterCell()
        snowCell.contents = UIImage(systemName: "snowflake")?.cgImage
        snowCell.scale = 0.05
        snowCell.birthRate = 10
        snowCell.lifetime = 10.0
        snowCell.velocity = 50
        snowCell.emissionLongitude = .pi
        
        snowLayer?.emitterCells = [snowCell]
        if let snowLayer = snowLayer {
            targetView?.layer.addSublayer(snowLayer)
        }
    }
    
    private func addMistAnimation() {
        mistLayer = CAEmitterLayer()
        mistLayer?.emitterPosition = CGPoint(x: targetView?.bounds.width ?? 0 / 2, y: -10)
        mistLayer?.emitterShape = .line
        mistLayer?.emitterSize = CGSize(width: targetView?.bounds.width ?? 0, height: 1)
        
        let mistCell = CAEmitterCell()
        mistCell.contents = UIImage(systemName: "cloud.fill")?.cgImage
        mistCell.scale = 0.1
        mistCell.birthRate = 5
        mistCell.lifetime = 15.0
        mistCell.velocity = 30
        mistCell.emissionLongitude = .pi
        
        mistLayer?.emitterCells = [mistCell]
        if let mistLayer = mistLayer {
            targetView?.layer.addSublayer(mistLayer)
        }
    }
    
    private func addStarsOverlay() {
        starsLayer = CAEmitterLayer()
        starsLayer?.emitterPosition = CGPoint(x: targetView?.bounds.width ?? 0 / 2, y: -10)
        starsLayer?.emitterShape = .line
        starsLayer?.emitterSize = CGSize(width: targetView?.bounds.width ?? 0, height: 1)
        
        let starCell = CAEmitterCell()
        starCell.contents = UIImage(systemName: "star.fill")?.cgImage
        starCell.scale = 0.05
        starCell.birthRate = 5
        starCell.lifetime = 8.0
        starCell.velocity = 100
        starCell.emissionLongitude = .pi
        
        starsLayer?.emitterCells = [starCell]
        if let starsLayer = starsLayer {
            targetView?.layer.addSublayer(starsLayer)
        }
    }
}
