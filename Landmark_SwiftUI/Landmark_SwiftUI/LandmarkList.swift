//
//  LandmarkList.swift
//  Landmark_SwiftUI
//
//  Created by 임영선 on 2023/02/28.
//

import SwiftUI

struct LandmarkList: View {
    
    @StateObject private var viewModel = LandmarkViewModel()
    @State private var isShowOnlyFavorite = true
    
    var body: some View {
        List {
            
            Toggle(isOn: $isShowOnlyFavorite) {
                Text("Favorites Only")
            }
            
            let landmark = getLandmark()
            ForEach(landmark) { landmark in
                LandmarkRow(landmark: landmark)
            }
        }
        .navigationTitle("Landmark List")
      
    }
    
    private func getLandmark() -> [Landmark] {
        viewModel.landmarks.filter { landmark in
            return landmark.isFavorite || !isShowOnlyFavorite
        }
    }
    
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}
