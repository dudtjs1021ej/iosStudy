//
//  CommentsTableViewCell.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

   
    @IBOutlet var starImageView: [UIImageView]!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentsLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //rating에 대한 star imageView 설정하는 메소드
    func setStarImage(rating: Double) {
        let rating = rating / 2
        switch rating {
        case 0 ..< 1:
            starImageView[0].image = UIImage(named: "ic_star_large_full")
            starImageView[1].image = UIImage(named: "ic_star_large")
            starImageView[2].image = UIImage(named: "ic_star_large")
            starImageView[3].image = UIImage(named: "ic_star_large")
            starImageView[4].image = UIImage(named: "ic_star_large")
            
        case 1 ..< 2:
            starImageView[0].image = UIImage(named: "ic_star_large_full")
            starImageView[1].image = UIImage(named: "ic_star_large_full")
            starImageView[2].image = UIImage(named: "ic_star_large")
            starImageView[3].image = UIImage(named: "ic_star_large")
            starImageView[4].image = UIImage(named: "ic_star_large")
            
        case 2 ..< 3:
            starImageView[0].image = UIImage(named: "ic_star_large_full")
            starImageView[1].image = UIImage(named: "ic_star_large_full")
            starImageView[2].image = UIImage(named: "ic_star_large_full")
            starImageView[3].image = UIImage(named: "ic_star_large")
            starImageView[4].image = UIImage(named: "ic_star_large")
            
        case 3 ..< 4:
            starImageView[0].image = UIImage(named: "ic_star_large_full")
            starImageView[1].image = UIImage(named: "ic_star_large_full")
            starImageView[2].image = UIImage(named: "ic_star_large_full")
            starImageView[3].image = UIImage(named: "ic_star_large_full")
            starImageView[4].image = UIImage(named: "ic_star_large")
            
        case 4 ..< 5:
            starImageView[0].image = UIImage(named: "ic_star_large_full")
            starImageView[1].image = UIImage(named: "ic_star_large_full")
            starImageView[2].image = UIImage(named: "ic_star_large_full")
            starImageView[3].image = UIImage(named: "ic_star_large_full")
            starImageView[4].image = UIImage(named: "ic_star_large_full")
            
        default:
            break
        }
    }
    

}
