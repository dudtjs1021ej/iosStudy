//
//  ViewController.swift
//  VisualBookManager
//
//  Created by 임영선 on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {
    
    let myBookManager = BookManager()
    
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let book1 = Book(name: "햄릿", genre: "비극", author: "셰익스피어")
        //book1.bookPrint()

        let book2 = Book(name: "총균쇠", genre: "역사", author: "재레드 다이아몬드")
        //book2.bookPrint()

        let book3 = Book(name: "죄와벌", genre: "사실주의", author: "톨스토이")
        //book3.bookPrint()

        myBookManager.registerBook(bookObject: book1)
        myBookManager.registerBook(bookObject: book2)
        myBookManager.registerBook(bookObject: book3)
        
        countLabel.text = "\(myBookManager.countBooks())"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any){
        var bookTemp = Book()
        bookTemp.name = nameTextField.text!
        bookTemp.author = authorTextField.text!
        bookTemp.genre = genreTextField.text!
        
        myBookManager.registerBook(bookObject: bookTemp)
        outputTextView.text = "\(nameTextField.text!) has been registered"
        countLabel.text = "\(myBookManager.countBooks())"
    }
    
    @IBAction func showAllBookAction(_ sender: Any){
//        print("showAllBookAction")
        outputTextView.text = myBookManager.showAllBooks()
    }
    
    @IBAction func searchAction(_ sender: Any){
        let resultBook = myBookManager.searchBook(name: nameTextField.text!)
        if resultBook != nil{
            outputTextView.text = resultBook
        }else{
            outputTextView.text = "we don't have book"
        }
    }
    
    @IBAction func removeAction(_ sender: Any){
        myBookManager.removeBook(name: nameTextField.text!)
        outputTextView.text = "\(nameTextField.text!) removed"
        countLabel.text = "\(myBookManager.countBooks())"
    }


}

