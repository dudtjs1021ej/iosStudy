//
//  ViewController.swift
//  WeatherToday
//
//  Created by 임영선 on 2021/09/09.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    //MARK: property
    var countries: [Country] = []
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else{
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        }catch{
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    
    //MARK:- Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else{
            print("cell error")
            return UITableViewCell()
        }
        
        let country: Country = self.countries[indexPath.row]
        
        cell.countryLabel.text = country.korean_name //cell 나라 이름
        cell.imgView.image = UIImage(named: "flag_\(country.asset_name)") //cell 이미지뷰
        cell.countryKoreanName = country.korean_name
        cell.countryEnglishName = country.asset_name
        return cell
    }
    
    //Navigation 되기전에 데이터를 보내는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: CityViewController = segue.destination as? CityViewController else{
            return
        }
        
        guard let cell: CountryTableViewCell = sender as? CountryTableViewCell else{
            return
        }
        //한글,영어 나라 이름  nextViewController로 데이터 넘겨줌
        nextViewController.countryKoreanName = cell.countryKoreanName
        nextViewController.countryEnglishName = cell.countryEnglishName
    }


}

