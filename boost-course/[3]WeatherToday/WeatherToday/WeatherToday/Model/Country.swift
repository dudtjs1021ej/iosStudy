//
//  Country.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/10.
//

import Foundation

// {"korean_name":"한국","asset_name":"kr"}
struct Country: Codable{
    let korean_name: String
    let asset_name: String
}
