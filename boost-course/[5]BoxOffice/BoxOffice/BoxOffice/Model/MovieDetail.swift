//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import Foundation
/*
{
 audience: 11676822,
 grade: 12,
 actor: "하정우(강림), 차태현(자홍), 주지훈(해원맥), 김향기(덕춘)",
 duration: 139,
 reservation_grade: 1,
 title: "신과함께-죄와벌",
 reservation_rate: 35.5,
 user_rating: 7.98,
 date: "2017-12-20",
 director: "김용화",
 id: "5a54c286e8a71d136fb5378e",
 image:
"http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
jpg",
synopsis: "저승 법에 의하면, (중략) 고난과 맞닥뜨리는데… 누구나 가지만 아무도 본 적 없는 곳, 새
로운 세계의 문이 열린다!",
 genre: "판타지, 드라마"
}
}
 */

struct MovieDetail: Codable {
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let director: String
    let id: String
    let image: String
    let synopsis: String
    let genre: String
    
    var getGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        }else{
            return "ic_\(grade)"
        }
    }
    
    var getGenreDuration: String{
        return "\(genre) / \(duration)분"
    }
    
    var getReservation: String {
        return "\(reservation_grade)위 \(reservation_rate)%"
    }
    
    var getDate: String {
        return "\(date) 개봉"
    }
    
    
}
