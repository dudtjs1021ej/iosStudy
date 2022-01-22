//
//  Comment.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/10/05.
//

import Foundation

//한줄평 구조체
struct Comment: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
}
