//
//  City.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/10.
//

import Foundation
/*
{
   "city_name":"로마",
   "state":11,
   "celsius":25.5,
   "rainfall_probability":90
}
*/

struct City: Codable{
    let city_name: String
    let state: Int
    let celsius: Double
    let rainfall_probability: Int
}
