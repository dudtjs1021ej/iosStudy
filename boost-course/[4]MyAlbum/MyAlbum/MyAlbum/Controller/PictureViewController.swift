//
//  PictureViewController.swift
//  MyAlbum
//
//  Created by 임영선 on 2021/09/17.
//

import UIKit
import Photos

class PictureViewController: UIViewController {
    
    //MARK: - properties
    var pictures: PHFetchResult<PHAsset>!
    var albumName: String!
    var albumIndex: Int!
    var imageArray = [PHAsset]() //이미지배열
    var deleteImagesArray = [PHAsset]() //삭제할 이미지 배열
    var exportImagesArray = [PHAsset]() //내보낼 이미지 배열
    var selectedIndexPath: [IndexPath : Bool] = [:] //선택된 이미지들 indexPath
    let imageManager: PHCachingImageManager = PHCachingImageManager() //앨범에서 사진을 받아오기 위한 객체
    
    //MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var exportButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var sortedButton: UIBarButtonItem!
    
    //MARK:- methods
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self) //포토라이브러리 변경사항 감지
        
        let flowLayout: UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        let half: Double = Double(UIScreen.main.bounds.width/3 - 10)
        flowLayout.itemSize = CGSize(width: half, height: half)
        flowLayout.sectionInset = UIEdgeInsets.zero //margin 0
        flowLayout.minimumInteritemSpacing = 10 //cell 사이의 최소 여백
        flowLayout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = flowLayout
        
        exportButton.isEnabled = false
        deleteButton.isEnabled = false

        
    }
    
    @IBAction func selectPicture(_ sender: UIBarButtonItem) {
        if sender.title == "선택" {
            sender.title = "취소"
            deleteButton.isEnabled = true
            exportButton.isEnabled = true
        }
        else {
            sender.title = "선택"
            deleteButton.isEnabled = false
            exportButton.isEnabled = false
        }
    }
    
    //선택한 사진 내보내기
    @IBAction func exportPicture(_ sender: UIBarButtonItem) {
        print("export")
        var exportImages = [UIImage]()
        for (key, value) in selectedIndexPath{
                   if value == true{ //선택된 이미지들만
                       let asset = imageArray[key.row]
                       imageManager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: {
                           (image, _ ) in
                           
                           if let selectedImage = image{
                            exportImages.append(selectedImage)
                           }
                       })
                   }
               }
               let shareSheetVC = UIActivityViewController(activityItems: exportImages, applicationActivities: nil)
               self.present(shareSheetVC, animated: true, completion: nil)
    }
    
    //선택한 사진 삭제
    @IBAction func deletePicture(_ sender: UIBarButtonItem) {
        deleteImagesArray.removeAll()
        
        for (key, value) in selectedIndexPath {
            if value ==  true {
                deleteImagesArray.append(imageArray[key.row]) //삭제할 이미지들 넣음
            
            }
        }
        
        let assetsToDelete = deleteImagesArray
        
        for i in 0..<assetsToDelete.count{
            PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.deleteAssets([assetsToDelete[i]] as NSArray)}, completionHandler: nil)
        }
    
        selectButton.title = "선택"
        exportButton.isEnabled = false
        deleteButton.isEnabled = false
        
        self.collectionView.reloadData()
    }
    
    //사진 정렬
    @IBAction func sortedPicture(_ sender: UIBarButtonItem) {
        let fetchOptions = PHFetchOptions()
        
        if sender.title == "최신순"{ //최신순 -> 과거순
            sender.title = "과거순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)] //true -> 과거순
            self.pictures = PHAsset.fetchAssets(with: fetchOptions)
            self.collectionView.reloadData()
            
        }else{ //과거순 -> 최신순
            sender.title = "최신순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] //false -> 최신순
            self.pictures = PHAsset.fetchAssets(with: fetchOptions)
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pictureDetail" {
            
            guard let nextViewController: PictureDetailViewController = segue.destination as? PictureDetailViewController else{
                return
            }
            
            guard let cell: PictureCollectionViewCell = sender as? PictureCollectionViewCell else{
                return
            }
            
            guard let index: IndexPath = self.collectionView.indexPath(for: cell) else{
                return
            }
            
            nextViewController.picture = pictures[index.row]
        }
            
          
        
    
}
}
//MARK:- collectionView
extension PictureViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PictureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? PictureCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        let picture = pictures.object(at: indexPath.row)
        imageArray.append(picture) //이미지배열에 추가
        imageManager.requestImage(for: picture, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in
            cell.imgView?.image = image
            cell.imgView.alpha = 1
            
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hi")
        guard let cell = collectionView.cellForItem(at: indexPath) as? PictureCollectionViewCell else{
                  return
        }
        if selectButton.title == "취소" {
            print("select")
            switch cell.imgView.alpha{
            case 1:
                cell.imgView.alpha = 0.5
                selectedIndexPath[indexPath] = true
            case 0.5:
                cell.imgView.alpha = 1
            default:
                cell.imgView.alpha = 1
            }
            
            exportButton.isEnabled = true
            deleteButton.isEnabled = true
        }
        else{
            let selectedImage = imageArray[indexPath.item]
            
            guard let pictureDetailVC = self.storyboard?.instantiateViewController(identifier: "pictureDetailVC") as? PictureDetailViewController else{
                return
            }
            pictureDetailVC.picture = selectedImage
            self.show(pictureDetailVC, sender: self)
        }
        
    }
}

//포토라이브러리 변화할 때
//MARK:- PHPhotoLibraryChangeObserver
extension PictureViewController: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: pictures) else{
            return
        }
        
        pictures = changes.fetchResultAfterChanges //바뀐 값 다시 저장
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
}
    
    

