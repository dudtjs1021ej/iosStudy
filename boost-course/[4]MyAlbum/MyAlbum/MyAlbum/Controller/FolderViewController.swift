//
//  ViewController.swift
//  MyAlbum
//
//  Created by 임영선 on 2021/09/15.
//

import UIKit
import Photos

class FolderViewController: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: properties
    let cellIdentifier: String = "cell"
    var fetchResult: [PHFetchResult<PHAsset>] = [] //앨범정보
    let imageManager: PHCachingImageManager = PHCachingImageManager() //앨범에서 사진을 받아오기 위한 객체
    var albumModel: [AlbumModel] = [AlbumModel]()
    var albumName: [String] = []
    var assetCount: [Int] = []
    var fetchOptions: PHFetchOptions{ //앨범 정보 옵션(날짜순)
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] //날짜순으로
        return fetchOptions
    }
    
    //MARK:- methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근허가됨")
            self.requestCollection()
            OperationQueue.main.addOperation {
                self.collectionView.reloadData()
            }
            
        case .denied:
            print("접근불허")
            
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({
                (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                    
                case .denied:
                    print("사용자가 불허함")
                    
                default:
                    break
                }
            })
            
        case .restricted:
            print("접근제한")
            
        default:
            break
    
        }
        
        self.collectionView.reloadData()
        
//        let flowLayout: UICollectionViewFlowLayout
//        flowLayout = UICollectionViewFlowLayout()
//        flowLayout.sectionInset = UIEdgeInsets.zero //margin 0
//        flowLayout.minimumInteritemSpacing = 20 //cell 사이의 최소 여백
//        flowLayout.minimumLineSpacing = 20
//
//
//        let halfWidth: CGFloat = UIScreen.main.bounds.width/2
//
//        flowLayout.estimatedItemSize = CGSize(width: 300 , height: 300)
//        self.collectionView.collectionViewLayout = flowLayout
      
    }
    func requestCollection() {
        
        //cameraRoll
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        //favoriteList
        let favoriteList = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        
        //albumList
        let albumList = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
        
        [cameraRoll, favoriteList, albumList].forEach{
                    
                    $0.enumerateObjects { collection, _, _ in
                        
                        let album = collection
                        let albumTitle : String = album.localizedTitle!
                        
                        let assetsFetchResult: PHFetchResult = PHAsset.fetchAssets(in: album, options: self.fetchOptions)
                        let albumCount = assetsFetchResult.count
                        
                        let newAlbum = AlbumModel(name: albumTitle, count: albumCount, collection: album)

                        self.albumModel.append(newAlbum)
                    }
        }
        addAlbums(collection: cameraRoll)
        addAlbums(collection: favoriteList)
        addAlbums(collection: albumList)

    }
    func addAlbums(collection : PHFetchResult<PHAssetCollection>){
        for i in 0 ..< collection.count {
            let collection = collection.object(at: i)
            self.fetchResult.append(PHAsset.fetchAssets(in: collection, options: fetchOptions))
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "picture" {
            
            guard let nextViewController: PictureViewController = segue.destination as? PictureViewController else{
                return
            }
            
            
            guard let cell: FolderCollectionViewCell = sender as? FolderCollectionViewCell else{
                return
            }
            
            guard let index: IndexPath = self.collectionView.indexPath(for: cell) else{
                return
            }
            
            nextViewController.pictures = fetchResult[index.row]
            nextViewController.albumName = albumModel[index.row].name
            nextViewController.albumIndex = index.row
            print(index.row)
        }
    }

}


//MARK:- collectionView
extension FolderViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FolderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FolderCollectionViewCell
        
        if let asset: PHAsset = fetchResult[indexPath.row].firstObject{ //앨범의 처음사진이 있는 경우만 거져옴
            imageManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: nil, resultHandler: {
                image, _ in
                cell.imgView?.image = image
            })
        }
            
      
        cell.folderLabel.text = albumModel[indexPath.row].name
        cell.numLabel.text = String(albumModel[indexPath.row].count)
        
        return cell
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout
extension FolderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = collectionView.frame.width
       
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        
        let cellWidth = (width-widthPadding) / itemsPerRow
        let cellHeight = cellWidth + 50
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets.left
    }
}

