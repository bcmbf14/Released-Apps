//
//  ViewController.swift
//  BcbfForecast
//
//  Created by jongchankim on 2020/05/04.
//  Copyright © 2020 JongChan KIm. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        return m
    }()
    
    
    let tempFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0 //소수점이 0인 경우엔 출력하지 않고
        f.maximumFractionDigits = 1 //나머지 경우에는 1자리만 출력한다.
        return f
    }()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale =  Locale(identifier: "Ko_kr")
        return f
    }()
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.backgroundColor = UIColor.clear
        listTableView.separatorStyle = .none
        listTableView.showsVerticalScrollIndicator = false
        
        WeaterDataSource.shared.fetchSummary(lat: 37.498206, lon: 127.02761) { [weak self]  in
            self?.listTableView.reloadData()
        }
        
        WeaterDataSource.shared.fetchForecast(lat: 37.498206, lon: 127.02761) { [weak self]  in
            self?.listTableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationLabel.text = "업데이트 중..."
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                updateCurrentLocation()
            case .denied, .restricted:
                show(message: "위치 서비스 사용 불가")
            default:
                fatalError()
            }
            
            
        } else{
            show(message: "위치 서비스 사용 불가")
        }
        
    }
    
    var topInset: CGFloat = 0.0
    
    //뷰 배치가 완료된 다음에 호출.
    //라이프 사이클 동안 반복적으로 호출.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if topInset == 0.0 {
            let first = IndexPath(row: 0, section: 0)
            if let cell = listTableView.cellForRow(at: first)  {
                topInset = listTableView.frame.height - cell.frame.height
                
                var inset = listTableView.contentInset
                inset.top = topInset
                listTableView.contentInset = inset
            }
        }
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func updateCurrentLocation(){
        locationManager.startUpdatingLocation() //사용자의 위치가 업데이트 될때마다 델리게이트를 통해 알려줌
    }
    
    
    //위치정보가 업데이트 될떄마다 반복적으로 알려줌
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let loc = locations.first {
            print(loc.coordinate)
            
//        Geocoding
//        특정 주소나 명칭을 사용해서 좌표를 얻는 것
//        Reverse Geocoding
//        좌표를 주소로 바꾸는 것
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(loc) { [weak self] (placemarks, error) in
//                하나의 명칭에 대한 여러가지 명칭이 있을 수 있어서 배열로 전달해줌
                if let place = placemarks?.first {
                    
                    //미국 기준이기 때문에 우리나라 구랑 동을 받아와야 함
                    if let gu = place.locality, let dong = place.subLocality {
                        self?.locationLabel.text = "\(gu) \(dong)"
                    }else{
                        self?.locationLabel.text = place.name
                    }
                }
            }
            
        }
        
        //계속 알려주면 배터리가 소모되니까 한번만 받고 그만받기. 배터리절약. 위치기반 배터리 아주중요.
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        show(message: error.localizedDescription)
        manager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            updateCurrentLocation()
        default:
            print("")
//            fatalError()
        }
    }
    
}


extension ViewController:UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return WeaterDataSource.shared.forecastList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            
            if let data = WeaterDataSource.shared.summary?.weather.minutely.first {
                cell.weatherImageView.image = UIImage(named: data.sky.code)
                cell.statusLabel.text = data.sky.name
                
                let max = Double(data.temperature.tmax) ?? 0.0
                let min = Double(data.temperature.tmin) ?? 0.0
                let maxStr = tempFormatter.string(for: max) ?? "-"
                let minStr = tempFormatter.string(for: min) ?? "-"
                cell.minMaxLabel.text = "최대 \(maxStr)º 최소 \(minStr)º"
                
                let current = Double(data.temperature.tc) ?? 0.0
                let currentStr = tempFormatter.string(for: current) ?? "-"
                cell.currentTemperatureLabel.text = currentStr
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        
        let target = WeaterDataSource.shared.forecastList[indexPath.row]
        
        dateFormatter.dateFormat = "M.d (E)"
        cell.dateLabel.text = dateFormatter.string(for: target.date)
        
        dateFormatter.dateFormat = "HH:00"
        cell.timeLabel.text = dateFormatter.string(for: target.date)
        
        cell.weatherImageView.image = UIImage(named: target.skyCode)
        
        cell.statusLabel.text = target.skyName
        
        let tempStr = tempFormatter.string(for: target.temperature) ?? "-"
        cell.temperatureLabel.text = tempStr
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
}
