//
//  ViewController.swift
//  NavigationBarItem_no_storyboard
//
//  Created by 임영선 on 2022/05/16.
//

import UIKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.title = "홈"
    self.view.backgroundColor = .lightGray
    
    // 네비게이션 아이템 추가
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
  }

  @objc fileprivate func goToProfileVC() {
    print("MainVC - goToProfileVC")
    let vc = ProfileViewController()
    self.navigationController?.pushViewController(vc, animated: true)
    
  }
  
  @objc fileprivate func goToMessageVC() {
    print("MainVC - goToMessageVC")
    let vc = MessageViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

