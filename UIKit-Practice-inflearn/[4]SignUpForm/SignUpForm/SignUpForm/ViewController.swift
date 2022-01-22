//
//  ViewController.swift
//  SignUpForm
//
//  Created by 임영선 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UILabel!
    
    @IBOutlet weak var telTextField: UILabel!
    
    
    @IBOutlet weak var blogTextField: UILabel!
    
    @IBOutlet weak var outputTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameTextField.delegate = self //delegate
    }
    @IBAction func signUpAction(_ sender: Any) {
        outputTextView.text = "\(nameTextField.text!)님 가입을 축하합니다!"
    }
    
    //Done 버튼(return) 누르면 키보드 내리는 함수
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        nameTextField.resignFirstResponder() //키보드 내림
//        emailTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
//        telTextField.resignFirstResponder()
//        blogTextField.resignFirstResponder()
        textField.resignFirstResponder()
        return true
    }
    
    //다른 뷰 클릭 시 키보드 내리는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

