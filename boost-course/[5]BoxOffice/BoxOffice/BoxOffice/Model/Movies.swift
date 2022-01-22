//
//  Movies.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import Foundation
/*
{
 order_type:1,
 movies: [
 {
 grade: 12,
 thumb:
"http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
jpg?type=m99_141_2",
 reservation_grade: 1,
 title: "신과함께-죄와벌",
 reservation_rate: 35.5,
 user_rating: 7.98,
 date: "2017-12-20",
 id: "5a54c286e8a71d136fb5378e"
 },
}
*/

struct APIResponse: Codable {
    let movies: [Movies]
    let order_type: Int

}

struct Movies: Codable {
    let grade: Int
    let thumb: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String

    var getGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        }else{
            return "ic_\(grade)"
        }
    }
    
    var ReservationGradeRate: String {
        return "\(reservation_grade)위(\(user_rating)) / \(reservation_rate)%"
    }

}


