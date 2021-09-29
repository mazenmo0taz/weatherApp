//
//  WeatherData.swift
//  Clima
//
//  Created by mazen moataz on 27/09/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main: Codable{
    let temp : Float
}

struct Weather : Codable{
    let id : Int
}
