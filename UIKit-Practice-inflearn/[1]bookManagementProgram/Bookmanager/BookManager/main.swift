//
//  main.swift
//  BookManager
//
//  Created by 임영선 on 2021/08/05.
//

import Foundation

var book1 = Book(name: "햄릿", genre: "비극", author: "셰익스피어")
//book1.bookPrint()

var book2 = Book(name: "총균쇠", genre: "역사", author: "재레드 다이아몬드")
//book2.bookPrint()

var book3 = Book(name: "죄와벌", genre: "사실주의", author: "톨스토이")
//book3.bookPrint()

var myBookManager = BookManager()
myBookManager.registerBook(bookObject: book1)
myBookManager.registerBook(bookObject: book2)
myBookManager.registerBook(bookObject: book3)

print(myBookManager.showAllBooks())

print("nuber of books : \(myBookManager.countBooks())")

//var searchResult = myBookManager.searchBook(name: "죄와벌")
//
//if searchResult != nil{
//    print("\(searchResult!) 를 찾았습니다")
//}else{
//    print("찾으시는 책이 없습니다")
//}

if let searchResult = myBookManager.searchBook(name: "죄와벌"){
    print("\(searchResult) 를 찾았습니다")
}else{
    print("찾으시는 책이 없습니다")
}

myBookManager.removeBook(name: "죄와벌")
print(myBookManager.showAllBooks())
print("number of books : \(myBookManager.countBooks())")
