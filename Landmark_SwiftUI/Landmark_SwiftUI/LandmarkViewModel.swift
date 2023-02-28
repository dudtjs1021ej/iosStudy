//
//  LandmarkViewModel.swift
//  Landmark_SwiftUI
//
//  Created by 임영선 on 2023/02/28.
//

import Foundation

class LandmarkViewModel: ObservableObject {
    
    @Published var landmarks: [Landmark] = ResourceLoader().loadLandmarks()
}
