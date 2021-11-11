//
//  FeedCell.swift
//  InstagramCloneApp
//
//  Created by 임영선 on 2021/11/11.
//

import UIKit
class FeedCell: UICollectionViewCell {
    //MARK: - Properties
    private var profileImageView: UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .red
       // iv.image = UIImage(named: "venom-7")
        return iv
    }
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) error")
    }
    
    //MARK: - Actions
    @objc func didTapUsername() {
        print("didtap")
    }
}
