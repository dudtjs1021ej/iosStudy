//
//  FeedController.swift
//  InstagramCloneApp
//
//  Created by 임영선 on 2021/11/10.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    //MARK: - Helpers
    func configureUI(){
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier) //컬렉션뷰 셀 등록
    }

}
//MARK:- UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        //cell.backgroundColor = .red
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
