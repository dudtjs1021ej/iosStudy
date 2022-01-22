//
//  Comments.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import Foundation
struct commentAPIResponse: Codable {
    let comments: [Comments]
   // let movie_id: String
}
struct Comments: Codable {
    let id: String
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
    
    var timestampToDate: String {
           let date = Date(timeIntervalSince1970: timestamp)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
           
           return dateFormatter.string(from: date)
       }
}
