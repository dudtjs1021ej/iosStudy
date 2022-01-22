//
//  DetailViewController.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/09.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK:- @IBOutlet
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    //MARK: properties
    var koreanWeather: String?
    var englishWeather: String?
    var temperature: Double?
    var precipitation: Int?
    var cityName: String?
    
    //MARK:- :LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = cityName
    
        if let weather = englishWeather{
            imgView.image = UIImage(named: weather)
        }
        stateLabel.text = koreanWeather
        if let precipitation = precipitation{
            precipitationLabel.text = "강수 확률 \(String(precipitation))%"
            if precipitation >= 60{
                precipitationLabel.textColor = UIColor.orange
            }
        }
        if let temperature = temperature{
            let fahrenheit: String = String(format:"%.1f", (temperature * 9/5) + 32)
            temperatureLabel.text = "섭씨 \(String(temperature))도 / 화씨 \(fahrenheit)도"
            if temperature <= 10{
                temperatureLabel.textColor = UIColor.blue
            }
            else if temperature >= 25{
                temperatureLabel.textColor = UIColor.red
            }
        }
       
    }
}
