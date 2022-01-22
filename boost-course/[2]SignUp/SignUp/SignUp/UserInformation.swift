//
//  UserInformation.swift
//  SignUp
//
//  Created by 임영선 on 2021/09/02.
//

import Foundation

class UserInformation{
    static let shared: UserInformation = UserInformation()
    var id: String?
    var password: String?
    var introduce: String?
    var phoneNumber: String?
    var dateOfBirth: String?
}
