//
//  ViewController.swift
//  FlightBooking
//
//  Created by 임영선 on 2021/08/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var departDateButton: UIButton!
    @IBOutlet weak var returnDateButton: UIButton!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var selectDatePicker: UIDatePicker!
    var buttonTag: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        returnDateLabel.isHidden = true //보이지 않음
        returnDateButton.isHidden = true
        selectDatePicker.isHidden = true
    }

    @IBAction func showDatePickerAction(_ sender: UIButton) {
        if selectDatePicker.isHidden == false{
            selectDatePicker.isHidden = true
        }
        else{
            selectDatePicker.isHidden = false
        }
        buttonTag = sender.tag //현재 태그 몇번이 들어온건지 알 수 있음
    }
    
    @IBAction func showReturnDateAction(_ sender: UISwitch) {
//        if returnDateButton.isHidden == false{
//            returnDateButton.isHidden = true
//            returnDateLabel.isHidden = true
//        }else{
//            returnDateButton.isHidden = false
//            returnDateLabel.isHidden = false
//        }
        
        
        //sender 사용 -> sender는 UISwitch
//        if (sender as! UISwitch).isOn{ //형 변환
//            returnDateLabel.isHidden = false
//            returnDateButton.isHidden = false
//        }else{
//            returnDateLabel.isHidden = true
//            returnDateButton.isHidden = true
//        }
        
        returnDateButton.isHidden = !sender.isOn //UISwitch의 상태와 hidden은 반대
        returnDateLabel.isHidden = !sender.isOn
    }
    
    @IBAction func selectedDateAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-MM-d hh:mma"
        
        let dateString = formatter.string(from: sender.date)
        
        if buttonTag == 1{
            departDateButton.setTitle(dateString, for: .normal)
        }else{
            returnDateButton.setTitle(dateString, for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        selectDatePicker.isHidden = true
    }
    
    
}

