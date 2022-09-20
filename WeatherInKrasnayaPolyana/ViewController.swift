//
//  ViewController.swift
//  WeatherInKrasnayaPolyana
//
//  Created by Ян Нурков on 20.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Elements
    
    let city = "Красная поляна"
    var weatherService = WeatherService()
    
    private lazy var tableViewMain: UITableView = {
        let obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        obj.backgroundColor = Colors.backgroundView
        return obj
    }()
    
    private lazy var contentView: UIView = {
        let obj = UIView()
        obj.backgroundColor = Colors.backgroundView
        return obj
    }()
    
    private lazy var weatherView: UIView = {
        let obj = UIView()
        obj.backgroundColor = Colors.backgroundViewsInformation
        obj.layer.cornerRadius = 24
        obj.layer.shadowColor = UIColor(red: 0.54, green: 0.54, blue: 0.55, alpha: 1.00).cgColor
        obj.layer.shadowOffset = CGSize.zero
        obj.layer.shadowRadius = 6.0
        obj.layer.shadowOpacity = 10
        return obj
    }()
    
    private lazy var weatherNowView: UIView = {
        let obj = UIView()
        obj.backgroundColor = Colors.backgroundViewsWeather
        obj.layer.cornerRadius = 24
        return obj
    }()
    
    private lazy var weatherNowImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(systemName: "sun.max")
        obj.tintColor = .white
        return obj
    }()
    
    private lazy var weatherNowTemperatureLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = .systemFont(ofSize: 20)
        obj.textAlignment = .center
        obj.textColor = .white
        obj.attributedText = makeTemperatureText(with: "21")
        return obj
    }()
    
    private lazy var weatherLabelNow: UILabel = {
        let obj = UILabel()
        obj.text = "Сейчас"
        obj.textAlignment = .center
        obj.textColor = .white
        obj.font = .systemFont(ofSize: 13)
        return obj
    }()
    
    private lazy var weatherTomorrowView: UIView = {
        let obj = UIView()
        obj.backgroundColor = Colors.backgroundViewsWeather
        obj.layer.cornerRadius = 24
        return obj
    }()
    
    private lazy var weatherTomorrowImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(systemName: "cloud.rain.fill")
        obj.tintColor = .white
        return obj
    }()
    
    private lazy var weatherTomorrowTemperatureLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = .systemFont(ofSize: 20)
        obj.textAlignment = .center
        obj.textColor = .white
        obj.attributedText = makeTemperatureText(with: "22")
        return obj
    }()
    
    private lazy var weatherLabelTomorrow: UILabel = {
        let obj = UILabel()
        obj.text = "Завтра"
        obj.textColor = .white
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 13)
        return obj
    }()
    
    private lazy var weatherAfterTomorrowView: UIView = {
        let obj = UIView()
        obj.backgroundColor = Colors.backgroundViewsWeather
        obj.layer.cornerRadius = 24
        return obj
    }()
    
    private lazy var weatherAfterTomorrowImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(systemName: "cloud.snow.fill")
        obj.tintColor = .white
        return obj
    }()
    
    private lazy var weatherAfterTomorrowTemperatureLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = .systemFont(ofSize: 20)
        obj.textAlignment = .center
        obj.attributedText = makeTemperatureText(with: "20")
        obj.textColor = .white
        return obj
    }()
    
    private lazy var weatherLabelAfterTomorrow: UILabel = {
        let obj = UILabel()
        obj.text = "Послезавтра"
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 13)
        obj.textColor = .white
        return obj
    }()
    
    private lazy var header: StretchyTableHeaderView = {
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250))
        header.imageView.image = UIImage(named: "KrasnayaPolyana")
        header.imageView.layer.cornerRadius = 24
        header.backgroundColor = Colors.backgroundView
        return header
    }()
  
    private lazy var cityName: UILabel = {
        let obj = UILabel()
        obj.textColor = Colors.backgroundViewsInformation
        obj.text = "Погода в Красной Поляне"
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 25)
        return obj
    }()
    
    private lazy var buttonReload: UIButton = {
        let obj = UIButton()
        obj.setTitle("Обновить", for: .normal)
        obj.backgroundColor = Colors.backgroundViewsInformation
        obj.tintColor = .white
        obj.titleLabel?.font = .systemFont(ofSize: 20)
        obj.addTarget(self, action: #selector(reloadWeather), for: .touchDown)
        obj.layer.cornerRadius = 25
        return obj
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let obj = UIActivityIndicatorView()
        obj.color = .black
        obj.style = .medium
        obj.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        return obj
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        makeConstraints()
        weatherService.fetchWeather(cityName: city)
    }
   
    // MARK: - Settings
    
    func configView() {
        self.view.addSubview(self.tableViewMain)
        self.header.addSubview(self.indicator)
        self.weatherService.delegate = self
        self.tableViewMain.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableViewMain.delegate = self
        self.tableViewMain.dataSource = self
        self.tableViewMain.frame = view.bounds
        self.tableViewMain.tableHeaderView = self.header
        self.tableViewMain.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.contentView.addSubview(self.weatherView)
        self.contentView.addSubview(self.cityName)
        self.weatherView.addSubview(self.weatherNowView)
        self.weatherView.addSubview(self.weatherTomorrowView)
        self.weatherTomorrowView.addSubview(self.weatherTomorrowImageView)
        self.weatherTomorrowView.addSubview(self.weatherTomorrowTemperatureLabel)
        self.weatherTomorrowView.addSubview(self.weatherLabelTomorrow)
        self.weatherView.addSubview(self.weatherAfterTomorrowView)
        self.weatherAfterTomorrowView.addSubview(self.weatherAfterTomorrowImageView)
        self.weatherAfterTomorrowView.addSubview(self.weatherAfterTomorrowTemperatureLabel)
        self.weatherAfterTomorrowView.addSubview(self.weatherLabelAfterTomorrow)
        self.weatherNowView.addSubview(self.weatherNowImageView)
        self.weatherNowView.addSubview(self.weatherNowTemperatureLabel)
        self.weatherNowView.addSubview(self.weatherLabelNow)
        self.contentView.addSubview(buttonReload)
        self.indicator.snp.makeConstraints { make in
            make.center.equalTo(self.header.snp.center)
            make.height.width.equalTo(50)
        }
    }
    
    
    func makeConstraints() {
        self.cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        self.weatherView.snp.makeConstraints { make in
            make.top.equalTo(self.cityName.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(250)
        }
        
        self.weatherNowView.snp.makeConstraints { make in
            make.left.equalTo(self.weatherView.snp.left).offset(16)
            make.top.equalTo(self.weatherView.snp.top).offset(16)
            make.bottom.equalTo(self.weatherView.snp.bottom).offset(-16)
            make.width.equalTo(self.weatherView.snp.height).dividedBy(2.5)
        }
        
        self.weatherNowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.weatherNowTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.weatherNowImageView.snp.bottom)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.weatherLabelNow.snp.makeConstraints { make in
            make.top.equalTo(self.weatherNowView.snp.top).offset(5)
            make.left.equalTo(self.weatherNowView.snp.left).offset(5)
            make.right.equalTo(self.weatherNowView.snp.right).offset(-5)
            make.height.equalTo(20)
        }
        
        self.weatherTomorrowView.snp.makeConstraints { make in
            make.centerX.equalTo(self.weatherView)
            make.centerY.equalTo(self.weatherView)
            make.width.height.equalTo(self.weatherNowView)
        }
        
        self.weatherTomorrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.weatherTomorrowTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.weatherTomorrowImageView.snp.bottom)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.weatherLabelTomorrow.snp.makeConstraints { make in
            make.top.equalTo(self.weatherTomorrowView.snp.top).offset(5)
            make.left.equalTo(self.weatherTomorrowView.snp.left).offset(5)
            make.right.equalTo(self.weatherTomorrowView.snp.right).offset(-5)
            make.height.equalTo(20)
        }
        
        self.weatherAfterTomorrowView.snp.makeConstraints { make in
            make.top.equalTo(self.weatherNowView.snp.top)
            make.right.equalTo(self.weatherView.snp.right).offset(-16)
            make.width.height.equalTo(self.weatherNowView)
        }
        
        self.weatherAfterTomorrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.weatherAfterTomorrowTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(self.weatherAfterTomorrowImageView.snp.bottom)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.weatherLabelAfterTomorrow.snp.makeConstraints { make in
            make.top.equalTo(self.weatherAfterTomorrowView.snp.top).offset(5)
            make.left.equalTo(self.weatherAfterTomorrowView.snp.left).offset(5)
            make.right.equalTo(self.weatherAfterTomorrowView.snp.right).offset(-5)
            make.height.equalTo(20)
        }
        
        self.buttonReload.snp.makeConstraints { make in
            make.top.equalTo(self.weatherView.snp.bottom).offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalTo(self.weatherView.snp.centerX)
        }
        
    }
    
    
    private func makeTemperatureText(with temperature: String) -> NSAttributedString {
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.white
        boldTextAttributes[.font] = UIFont.systemFont(ofSize: 20)
        
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.systemFont(ofSize: 18)
        
        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "°C", attributes: plainTextAttributes))
        
        return text
    }
    
    @objc func reloadWeather() {
        indicator.startAnimating()
        weatherService.fetchWeather(cityName: city)
    }
}

// MARK: - Setting TableView

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { make in
            make.top.equalTo(cell.snp.top)
            make.left.equalTo(cell.snp.left)
            make.right.equalTo(cell.snp.right)
            make.bottom.equalTo(cell.snp.bottom)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 650
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableViewMain.tableHeaderView as? StretchyTableHeaderView else {return}
        header.scrollViewDidScroll(scrollView: tableViewMain)
    }
}

// MARK: - WeatherServiceDelegate

extension ViewController: WeatherServiceDelegate {
    
    func didFetchWeather(_ weatherService: WeatherService, _ weather: WeatherModel) {
        self.weatherNowTemperatureLabel.attributedText = self.makeTemperatureText(with: weather.temperatureString1)
        self.weatherNowImageView.image = UIImage(systemName: weather.conditionName1)
        self.weatherTomorrowTemperatureLabel.attributedText = self.makeTemperatureText(with: weather.temperatureTomorrow)
        self.weatherTomorrowImageView.image = UIImage(systemName: weather.conditionNameTomorrow)
        self.weatherAfterTomorrowTemperatureLabel.attributedText = self.makeTemperatureText(with: weather.temperatureAfterTomorrow)
        self.weatherAfterTomorrowImageView.image = UIImage(systemName: weather.conditionNameAfterTomorrow)
        indicator.stopAnimating()
    }
    
    
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError) {
        let message: String
        
        switch error {
        case .network(statusCode: let statusCode):
            message = "Networking error. Status code: \(statusCode)."
        case .parsing:
            message = "JSON weather data could not be parsed."
        case .general(reason: let reason):
            message = reason
        }
        showErrorAlert(with: message)
    }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка получения погоды",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
