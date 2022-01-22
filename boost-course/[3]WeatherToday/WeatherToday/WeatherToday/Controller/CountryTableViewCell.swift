//
//  CountryTableViewCell.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/10.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    //MARK:- @IBOutlet
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    //MARK: properties
    var countryKoreanName: String?
    var countryEnglishName: String?
    
    //MARK:- methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
