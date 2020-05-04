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
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeaterDataSource.shared.fetchSummary(lat: 37.498206, lon: 127.02761) { [weak self]  in
            self?.listTableView.reloadData()
        }
        
    }
    
    
}


extension ViewController:UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
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
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
}
