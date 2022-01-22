//
//  SecondViewController.swift
//  SignUp
//
//  Created by 임영선 on 2021/09/02.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Properties
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true //사진 편집 -> 편집 허용
        return picker
    }()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //editing tapGesture 달아줌
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        self.view.addGestureRecognizer(tapGesture)

        //imageView에 tapGesture 달아줌
        let imageViewtapGesture = UITapGestureRecognizer(target: self, action: #selector(clickImageView))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(imageViewtapGesture)
        nextButton.isEnabled = false //다음 버튼 비활성화
    }
    //MARK:- @objc func
    @objc func tapView(_ sender: UITapGestureRecognizer){
        checkData()
        self.view.endEditing(true)
    }
    
    @objc func clickImageView(){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Methods
    //MARK: UIImagePickerControllerDelegate
    
    //imagePiceker cancel 버튼 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //image를 선택했을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imgView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
        checkData()
    }

    //MARK: @IBAction
    //취소 버튼 메소드
    @IBAction func cancelButtonAction(_ sender: Any) {
        //모든 정보 지움
         UserInformation.shared.id = nil
         UserInformation.shared.password = nil
         UserInformation.shared.introduce = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
   //MARK: CustomMethod
    //모든 정보가 입력되고 비밀번호가 같은지 체크하는 메소드
    func checkData(){
        //이미지뷰, 텍스트필드, 텍스트뷰가 다 비어있지 않고
        if imgView.image != nil && idTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && checkPasswordTextField.text?.isEmpty == false && textView.text.isEmpty == false{
            if passwordTextField.text == checkPasswordTextField.text{ //비밀번호를 같게 입력했으면
                nextButton.isEnabled = true //다음버튼 활성화
                
                UserInformation.shared.id = idTextField.text //정보 저장
                UserInformation.shared.password = passwordTextField.text
                UserInformation.shared.introduce = textView.text
            }
        }
        else{
            nextButton.isEnabled = false //다음버튼 비활성화
        }
    }
    
}
