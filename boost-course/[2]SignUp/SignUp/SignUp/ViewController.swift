//
//  ViewController.swift
//  SignUp
//
//  Created by 임영선 on 2021/09/02.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - @IBOutlet
    @IBOutlet weak var idTextField: UITextField!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        //옵셔널 바인딩 -> id가 있으면 idTextField text 값 넣어줌
        if let id = UserInformation.shared.id{
            idTextField.text = id
        }
    }

}

