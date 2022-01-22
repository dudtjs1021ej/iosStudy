//
//  AlbumModel.swift
//  MyAlbum
//
//  Created by 임영선 on 2021/09/17.
//

import Foundation
import Photos

class AlbumModel{
    var name: String
    var count: Int
    var collection: PHAssetCollection
    init(name: String, count: Int, collection: PHAssetCollection){
        self.name = name
        self.count = count
        self.collection = collection
    }
}
