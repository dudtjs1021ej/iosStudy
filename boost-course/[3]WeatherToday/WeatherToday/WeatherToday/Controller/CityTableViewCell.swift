//
//  CityTableViewCell.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/10.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    //MARK:- @IBOutlet
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    //MARK: properties
    var englishWeather: String?
    var koreanWeather: String?
    var temperature: Double?
    var precipitation: Int?
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
