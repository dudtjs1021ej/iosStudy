//
//  ViewController.swift
//  SelectCar
//
//  Created by 임영선 on 2021/08/15.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   

    @IBOutlet weak var imageView: UIImageView!
    let carCompanyName = ["Tesla","Lamborghini","Porsche"]
    var carModel = [String]()
    
    
    
    let tesla = ["Model S","Model X"]
    let lamborghini = ["aventador","veneno","huracan"]
    let porsche = ["911","boxter"]
    
    let teslaImageNames = ["tesla-model-s.jpg","tesla-model-x.jpg"]
    let lamborghiniImageNames = ["lamborghini-aventador.jpg","lamborghini-veneno.jpg","lamborghini-huracan.jpg"]
    let porscheImageNames = ["porsche-911.jpg","porsche-boxter.jpg"]
    
    var carModelImage = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carModel = tesla
        carModelImage = teslaImageNames
        imageView.layer.cornerRadius = 50.0
       // imageView.layer.masksToBounds = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //컴포넌트 개수 리턴
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //컴포넌트별 요소 개수 리턴
        if component == 0{
            return carCompanyName.count
        }else{
            return carModel.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { //0번 컴포넌트
            return carCompanyName[row]
        }else{ //1번 컴포넌트
            return carModel[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 && row == 0{
            carModel = tesla
            carModelImage = teslaImageNames
        }else if component == 0 && row == 1{
            carModel = lamborghini
            carModelImage = lamborghiniImageNames
        }else if component == 0 && row == 2{
            carModel = porsche
            carModelImage = porscheImageNames
        }
        pickerView.reloadAllComponents() //reload
        
        imageView.image = UIImage(named: carModelImage[pickerView.selectedRow(inComponent: 1)])
    }
}

