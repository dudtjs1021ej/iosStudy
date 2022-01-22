//
//  PictureDetailViewController.swift
//  MyAlbum
//
//  Created by 임영선 on 2021/09/17.
//

import UIKit
import Photos

class PictureDetailViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - properties
    var picture: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager() //앨범에서 사진을 받아오기 위한 객체

    //MARK: @IBOutlet
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
        
        imageManager.requestImage(for: picture, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in
            self.imgView?.image = image
        })
       
    }
    
    @IBAction func clickHeart(_ sender: UIBarButtonItem) {
        guard let asset = picture else{
            return
        }
        if sender.title == "🖤"{
            sender.title = "❤️"
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest(for: asset)
                request.isFavorite = true
            }, completionHandler: { success, error in
            
            })
        }else{
            sender.title = "🖤"
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetChangeRequest(for: asset)
                request.isFavorite = false
            }, completionHandler: { success, error in
           
            })
        }
    }
    
    @IBAction func exportPicture(_ sender: Any) {
        var detailImage: UIImage?
        guard let asset = picture else {
            return
        }
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil) { (image, _) in
            detailImage = image
        }
        
        guard let image = detailImage else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]
        self.present(activityViewController, animated: true, completion: nil)

    
    }
    
    @IBAction func deletePicture(_ sender: Any) {
        let asset = picture
        
        PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.deleteAssets([asset] as NSFastEnumeration)}, completionHandler: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
   
}
