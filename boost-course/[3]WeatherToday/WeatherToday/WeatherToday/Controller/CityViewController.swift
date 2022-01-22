//
//  CityViewController.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/09.
//

import UIKit

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    //MARK:- properties
    var countryKoreanName: String?
    var countryEnglishName: String?
    var cities: [City] = []

    //MARK: @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonDecoder: JSONDecoder = JSONDecoder()
        if let name = countryEnglishName{
            guard let dataAsset: NSDataAsset = NSDataAsset(name: name) else{
                    return
            }
            do {
                self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
            }catch{
                print(error.localizedDescription)
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = countryKoreanName //title 설정
    }
    
    //MARK: Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell else{
            print("cell error")
            return UITableViewCell()
        }
        
        let city = cities[indexPath.row]
        
        cell.temperatureLabel.textColor = .black
        cell.precipitationLabel.textColor = .black
        
        //도시이름
        cell.cityLabel.text = city.city_name
        
        //강수량
        if city.rainfall_probability >= 60{
            cell.precipitationLabel.textColor = UIColor.orange
        }
        cell.precipitationLabel.text = "강수 확률 \(String(city.rainfall_probability))%"
        cell.precipitation = city.rainfall_probability
        
        //기온
        if city.celsius <= 10{
            cell.temperatureLabel.textColor = UIColor.blue
        }
        else if city.celsius >= 25{
            cell.temperatureLabel.textColor = UIColor.red
        }
        let fahrenheit: String = String(format:"%.1f", (city.celsius * 9/5) + 32)
        cell.temperatureLabel.text = "섭씨 \(String(city.celsius))도 / 화씨 \(fahrenheit)도"
        cell.temperature = city.celsius
        
        //날씨 -> state = 10:sunny 11:snowy 12:rainy 13:cloudy
        switch city.state {
        case 10:
            cell.imgView.image = UIImage(named: "sunny")
            cell.englishWeather = "sunny"
            cell.koreanWeather = "맑음"
        case 11:
            cell.imgView.image = UIImage(named: "snowy")
            cell.englishWeather = "snowy"
            cell.koreanWeather = "눈"
        case 12:
            cell.imgView.image = UIImage(named: "rainy")
            cell.englishWeather = "rainy"
            cell.koreanWeather = "비"
        case 13:
            cell.imgView.image = UIImage(named: "cloudy")
            cell.englishWeather = "cloudy"
            cell.koreanWeather = "구름"
        default:
            break
        }
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //DetailViewController로 데이터를 전송하는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else{
            return
        }
        
        guard let cell: CityTableViewCell = sender as? CityTableViewCell else{
            return
        }
       
        nextViewController.cityName = cell.cityLabel.text
        nextViewController.temperature = cell.temperature
        nextViewController.precipitation = cell.precipitation
        nextViewController.koreanWeather = cell.koreanWeather
        nextViewController.englishWeather = cell.englishWeather
       
    }
    

}
