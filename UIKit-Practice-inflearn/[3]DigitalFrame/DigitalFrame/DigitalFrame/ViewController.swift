//
//  ViewController.swift
//  DigitalFrame
//
//  Created by 임영선 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let cuteImages = [UIImage(named: "1.jpg")!,
                          UIImage(named: "2.jpg")!,
                          UIImage(named: "3.jpg")!,
                          UIImage(named: "4.jpg")!,
                          UIImage(named: "5.jpg")!,
                          UIImage(named: "6.jpg")!,
                          UIImage(named: "7.jpg")!,
                          UIImage(named: "8.jpg")!,
                          UIImage(named: "9.jpg")!,
                          UIImage(named: "10.jpg")!,
                          UIImage(named: "11.jpg")!,
                          UIImage(named: "12.jpg")!,
                          UIImage(named: "13.jpg")!,
                          UIImage(named: "14.jpg")!,
                          UIImage(named: "15.jpg")!
        ]
        imgView.animationImages = cuteImages //애니메이션을 만들 이미지 배열을 넣음
        imgView.animationDuration = 15 //1초에 한 장씩
        
    }
    @IBAction func toggleButton(_ sender: Any){
        
        if imgView.isAnimating{ //animating하고 있다면
            imgView.stopAnimating() // 애니메이션 stop
            toggleButton.setTitle("start", for: .normal)
        }
        else{
            imgView.animationDuration = Double(speedSlider.value)
            imgView.startAnimating()
            toggleButton.setTitle("stop", for: .normal)
        }
    
    }
    
    @IBAction func speedSliderAction(_ sender: Any){
        imgView.animationDuration = Double(speedSlider.value)
        imgView.startAnimating()
        toggleButton.setTitle("stop", for: .normal)
        speedLabel.text = String(format: "%.2f", speedSlider.value) //소수점 둘쨋자리까지만 
       // imgView.animationDuration =
    }


}

