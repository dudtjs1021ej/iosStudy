//
//  ContentView.swift
//  Landmark_SwiftUI
//
//  Created by 임영선 on 2023/02/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LandmarkList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
