//
//  UIVIewController+Alert.swift
//  BcbfForecast
//
//  Created by jongchankim on 2020/05/05.
//  Copyright © 2020 JongChan KIm. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(message:String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
}
