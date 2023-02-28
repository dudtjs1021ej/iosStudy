//
//  Landmark.swift
//  Landmark_SwiftUI
//
//  Created by 임영선 on 2023/02/28.
//

import Foundation

struct Landmark: Codable, Identifiable {
    var name: String
    var id: Int
    var imageName: String
    var isFavorite: Bool
}
