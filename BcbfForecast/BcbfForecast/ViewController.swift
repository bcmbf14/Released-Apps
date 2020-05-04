//
//  ViewController.swift
//  BcbfForecast
//
//  Created by jongchankim on 2020/05/04.
//  Copyright © 2020 JongChan KIm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeaterDataSource.shared.fetchSummary(lat: 37.498206, lon: 127.02761) { [weak self]  in
            self?.listTableView.reloadData()
        }
        
        WeaterDataSource.shared.fetchForecast(lat: 37.498206, lon: 127.02761) { [weak self]  in
            self?.listTableView.reloadData()
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
