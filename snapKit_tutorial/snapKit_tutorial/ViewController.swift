//
//  ViewController.swift
//  snapKit_tutorial
//
//  Created by 임영선 on 2022/01/23.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
  
  // 기존 UIView 생성
  lazy var redBox = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  // Then 라이브러리를 사용하여 UIView 생성
  lazy var blueBox = UIView().then {
    $0.backgroundColor = .blue
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(redBox)
    self.view.addSubview(blueBox)
    
    // 기존 오토레이아웃 코드
    redBox.translatesAutoresizingMaskIntoConstraints = false
    
    redBox.widthAnchor.constraint(equalToConstant: 100).isActive = true
    redBox.heightAnchor.constraint(equalToConstant: 100).isActive = true
    redBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    redBox.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    // snapKit 라이브러리 사용
    blueBox.snp.remakeConstraints { make in
      make.height.width.equalTo(100)
      make.centerX.equalToSuperview()
      make.top.equalTo(redBox.snp.bottom).offset(20)
    }
  }


}
// SwiftUI를 빌려서 미리보기 가능
// option + cmd + enter 로 미리보기
// option + cmd + p 미리보기 돌리기
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
        
    }
} #endif

