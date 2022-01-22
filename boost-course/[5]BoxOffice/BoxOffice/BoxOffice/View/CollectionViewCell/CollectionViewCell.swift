//
//  CollectionViewCell.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movieId: String?
    
}
