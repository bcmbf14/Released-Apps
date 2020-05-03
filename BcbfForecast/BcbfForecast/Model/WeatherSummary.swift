//
//  WeatherSummary.swift
//  BcbfForecast
//
//  Created by jongchankim on 2020/05/04.
//  Copyright © 2020 JongChan KIm. All rights reserved.
//

import Foundation

struct WeatherSummary: Codable {
    
    struct Weather: Codable {
        struct Minutely: Codable{
            struct Sky: Codable {
                let code: String
                let name: String
            }
            
            struct Temperature:Codable {
                let tc: String
                let tmax: String
                let tmin: String
            }
            
            let sky: Sky
            let temperature: Temperature
            
        }
        
        let minutely: [Minutely]
    }
    
    struct Result: Codable {
        let code: Int
        let message: String
        
    }
    
    let weather: Weather
    let result: Result
}
