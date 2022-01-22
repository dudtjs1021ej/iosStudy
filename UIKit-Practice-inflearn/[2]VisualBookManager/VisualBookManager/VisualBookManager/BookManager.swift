//
//  BookManager.swift
//  BookManager
//
//  Created by 임영선 on 2021/08/06.
//

import Foundation

class BookManager{
    var bookList = [Book] ()
    
    func registerBook(bookObject: Book){
        bookList += [bookObject]
    }
    
    func showAllBooks() -> String{
        var strTemp = ""
        for bookTemp in bookList{
            strTemp += "Name: \(bookTemp.name!)\n"
            strTemp += "Genre: \(bookTemp.genre!)\n"
            strTemp += "Author: \(bookTemp.author!)\n"
            strTemp += "========================\n"
        }
        return strTemp
    }
    
    func countBooks() -> Int {
        return bookList.count
    }

    func searchBook(name: String) -> String? {
        var strTemp = ""
        for bookTemp in bookList{
            if bookTemp.name == name{
                strTemp += "Name: \(bookTemp.name!)\n"
                strTemp += "Genre: \(bookTemp.genre!)\n"
                strTemp += "Author: \(bookTemp.author!)\n"
                strTemp += "========================\n"
                return strTemp
            }
        }
        return nil

    }

    func removeBook(name: String){
        for (index, value) in bookList.enumerated(){ //enumerated : 튜플로 인덱스와 값을 넘겨줌
            if value.name! == name {
                bookList.remove(at: index)
            }
            
        }
    }
}
