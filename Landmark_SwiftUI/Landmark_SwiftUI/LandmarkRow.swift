//
//  LandmarkRow.swift
//  Landmark_SwiftUI
//
//  Created by 임영선 on 2023/02/28.
//

import SwiftUI

struct LandmarkRow: View {
    
    var landmark: Landmark
    
    var body: some View {
        
        HStack {
            let imageSize: Double = 50
            Image(landmark.imageName)
                .resizable()
                .frame(width: imageSize, height: imageSize)
            
            Text(landmark.name)
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star")
                    .foregroundColor(.gray)
            }
        }
       
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        let landmarks = ResourceLoader().loadLandmarks()
        LandmarkRow(landmark: landmarks[0]).previewLayout(.fixed(width: 300, height: 70))
    }
}
