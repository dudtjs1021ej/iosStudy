//
//  ViewController.swift
//  AppLifeCycle
//
//  Created by 임영선 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {

    //view가 올라오고 나서 바로 호출 -> 1번 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //view가 나타나기 전에 호출
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    //view가 나타나고 나서 호출
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    //view가 사라지기 전에 호출
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    //view가 사라지고 나서 호출
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    


}

