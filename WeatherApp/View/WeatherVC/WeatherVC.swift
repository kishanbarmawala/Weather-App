//
//  WeatherVC.swift
//  StockGroInterview
//
//  Created by Kishan Barmawala on 19/10/24.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    private var weatherViewModel = WeatherViewModel()
    private let locationManager = CLLocationManager()
    private var weatherManager: WeatherChanger?
    private var currentLocation: CLLocation? = nil
    private var locationStatus: CLAuthorizationStatus? = nil
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Enter city name"
        textField.leftView = UIView(frame: .init(origin: .zero, size: .init(width: 10, height: 10)))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let fetchWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get weather condition", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gpsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
    }
    
    private func setupUI() {
        
        weatherManager = WeatherChanger(view: self.view)
        
        view.addSubview(scrollView)
        view.addSubview(cityTextField)
        view.addSubview(fetchWeatherButton)
        view.addSubview(gpsButton)
        scrollView.addSubview(stackView)
  
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        fetchWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        gpsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            cityTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            fetchWeatherButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 16),
            fetchWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fetchWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            scrollView.topAnchor.constraint(equalTo: fetchWeatherButton.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cityTextField.heightAnchor.constraint(equalToConstant: 50),
            fetchWeatherButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -90),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            gpsButton.widthAnchor.constraint(equalToConstant: 60),
            gpsButton.heightAnchor.constraint(equalToConstant: 60),
            gpsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gpsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
        
        fetchWeatherButton.addTarget(self, action: #selector(fetchWeatherData), for: .touchUpInside)
        gpsButton.addTarget(self, action: #selector(handleGPSButtonTapped), for: .touchUpInside)

    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc private func fetchWeatherData() {
        view.endEditing(true)
        guard let city = cityTextField.text, !city.isEmpty else {
            showErrorAlert(message: "Please enter a city name.")
            return
        }
        retrieveWeatherData(city: city)
    }
    
    @objc private func handleGPSButtonTapped() {
        if locationStatus == .denied || locationStatus == .restricted ||
            locationStatus == .notDetermined {
            showErrorAlert(message: "Location permission is denied, please enable it from settings")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.refreshControl.endRefreshing()
            }
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    private func retrieveWeatherData(coordinate: CLLocationCoordinate2D? = nil, city: String? = nil) {
        ProgressHUD.show(text: city == nil ? "Fetching current weather condition..." : "Fetching \(city!) weather condition...")
        weatherViewModel.fetchWeatherData(coordinate: coordinate, city: city) { [weak self] response, city in
            self?.updateUI(data: response, city: city)
            self?.refreshControl.endRefreshing()
            ProgressHUD.hide()
        } onError: { [weak self] error in
            self?.showErrorAlert(message: error.errorMessage())
            self?.refreshControl.endRefreshing()
            ProgressHUD.hide()

        }
    }
    
    private func updateUI(data: [WeatherData], city: City) {
        stackView.removeAllSubviews()
        data.forEach { weatherData in
            let weatherView = LocationWeatherView()
            weatherView.configure(with: weatherData, city: city)
            stackView.addArrangedSubview(weatherView)
        }
        
        if let weatherName = data.first?.data?.first?.weather?.first?.description {
            weatherManager?.setupWeatherBackground(for: weatherName, city: city)
        }
        
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        retrieveWeatherData(coordinate: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error as NSError)")
        showErrorAlert(message: "Failed to get location. Please try again.")
        refreshControl.endRefreshing()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            locationStatus = manager.authorizationStatus
            switch manager.authorizationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    gpsButton.isEnabled = true
                    locationManager.startUpdatingLocation()
                case .denied, .restricted:
                    gpsButton.isEnabled = false
                    let error = UILabel()
                    error.text = "Permission denied to get current location\n\nYou can still manually enter your city name and get the weather condition."
                    error.numberOfLines = 0
                    error.textAlignment = .center
                    stackView.removeAllSubviews()
                    stackView.addArrangedSubview(error)
                case .notDetermined:
                    gpsButton.isEnabled = false
                    locationManager.requestWhenInUseAuthorization()
                default:
                    gpsButton.isEnabled = false
                    break
            }
        }
    }
    
}
