////
////  Request.swift
////  BoxOffice
////
////  Created by 임영선 on 2021/09/30.
////
//
//import Foundation
//
//func requestMovies(orderType: Int) -> [Movies] {
//    var movies: [Movies] = []
//    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType)") else {
//        print("movies url error")
//        return movies
//
//    }
//
//    let session: URLSession = URLSession(configuration:  .default)
//    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
//
//        if let error = error { //오류가 있을 때
//            print(error.localizedDescription)
//            return
//        }
//
//        guard let data = data else {return}
//
//        do {
//            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//            movies = apiResponse.movies //response 결과를 넣어줌
//
//            DispatchQueue.main.async { //메인스레드에서 실행
//                self.collectionView.reloadData()
//            }
//
//        }catch(let err) {
//            print(err.localizedDescription)
//        }
//    }
//    dataTask.resume()
//    return movies
//
//}
