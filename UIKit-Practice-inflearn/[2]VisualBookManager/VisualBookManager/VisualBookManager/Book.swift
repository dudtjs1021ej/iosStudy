//
//  Book.swift
//  BookManager
//
//  Created by 임영선 on 2021/08/05.
//

import Foundation

struct Book{
    var name: String
    var genre: String
    var author: String
    
    func bookPrint(){
        print("Name: \(name)")
        print("Genre: \(genre)")
        print("Author: \(author)")
        print("=====================")
    }
}
