//
//  ThirdViewController.swift
//  SignUp
//
//  Created by 임영선 on 2021/09/02.
//

import UIKit

class ThirdViewController: UIViewController {

    //MARK:- @IBOutlets
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK:- Properties
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.isEnabled = false //가입버튼 비활성화
        let date: Date = dataPicker.date
        dateLabel.text = dateFormatter.string(from: date) //datePicker에서 선택된 날짜 dateLabel text
       
    }
    
    //MARK:- Methods
    //MARK: IBActions
    //datePicker의 값이 변경될 때 호출되는 메소드
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        dateLabel.text = dateString
        checkData()
    }
    //tapGesture 메소드
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
        checkData()
    }
    
    //취소버튼 메소드
    @IBAction func cancelButtonAction(_ sender: Any) {
       //모든 정보 지움
        UserInformation.shared.id = nil
        UserInformation.shared.password = nil
        UserInformation.shared.introduce = nil
        UserInformation.shared.phoneNumber = nil
        UserInformation.shared.dateOfBirth = nil
        
        //창 2개 한꺼번에 닫음
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //이전버튼 메소드
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //가입버튼 메소드
    @IBAction func signUpButtonAction(_ sender: Any) {
        //창 2개 한꺼번에 닫음
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Custom Method
    //전화번호, 생년월일 모두 입력했는지 체크하는 메소드
    func checkData(){
        if phoneNumberLabel.text?.isEmpty == false && dateLabel.text?.isEmpty == false{
            signUpButton.isEnabled = true //가입버튼 활성화
            UserInformation.shared.dateOfBirth = dateLabel.text //정보 저장
            UserInformation.shared.phoneNumber = phoneNumberLabel.text
        }
        else{
            signUpButton.isEnabled = false //가입버튼 비활성화
        }
    }
    
}
