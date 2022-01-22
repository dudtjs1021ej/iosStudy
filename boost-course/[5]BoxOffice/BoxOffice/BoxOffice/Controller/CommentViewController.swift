//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/10/01.
//

import UIKit

class CommentViewController: UIViewController {

    //MARK:- @Outlet
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    //MARK: properties
    var movieTitle: String?
    var gradeImageName: String?
    var movieId: String?
    var rating: Double = 0.0
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        contentTextField.layer.borderColor = UIColor.lightGray.cgColor
       
        movieTitleLabel.text = movieTitle
        if let gradeImageName = gradeImageName {
            gradeImageView.image = UIImage(named: gradeImageName)
        }
    }
    
    //MARK:- Methods
    //별점 슬라이더 적용 메소드
    @IBAction func starSliderAction(_ sender: UISlider) {
        let roundValue = round(sender.value)
        for index in 1 ... 5 {
            if let startImage = view.viewWithTag(index) as? UIImageView {
                if index <= Int(roundValue) {
                    startImage.image = UIImage(named: "ic_star_large_full")
                } else {
                    startImage.image = UIImage(named: "ic_star_large")
                }
            }
        }
        starLabel.text = "\(String(Int(roundValue)))점"
        rating = Double(roundValue)
    }
    
    //한줄평 등록 메소드
    @IBAction func uploadComment(_ sender: Any) {
        //한줄평을 다 채우지 않았으면 alert 띄움
        if nameTextField.text?.isEmpty == true || contentTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "한줄평을 작성해주세요", message: nil, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }else {
            addComments(rating: rating, writer: nameTextField.text ?? "", movie_id: movieId ?? "", contents: contentTextField.text ?? "")
            self.navigationController?.popViewController(animated: true)
           
        }
        
    }
    
    //URLSession 사용 -> 한줄평 등록 메소드
    func addComments(rating: Double, writer: String, movie_id: String, contents: String) {
        
        let timestamp = NSDate().timeIntervalSince1970
        let comment = Comment(rating: rating, timestamp: timestamp, writer: writer, movie_id: movie_id, contents: contents)
        guard let uploadData = try? JSONEncoder().encode(comment) else {
            return
        }
        
        let strUrl = "http://connect-boxoffice.run.goorm.io/comment"
        
        guard let url: URL = URL(string: strUrl) else {
            print("URL error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("POST error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
        }
        task.resume()
    }


}
