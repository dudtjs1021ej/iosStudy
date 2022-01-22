//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import UIKit

class MovieDetailViewController: UIViewController {
    //MARK:- @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: properties
    var movieId: String?
    var movieTitle: String?
    var imageName: String?
    var movieDetail: MovieDetail?
    var cellIdentifier: [String] = ["MovieInfoCell", "SynopsisCell", "DirectorCell", "TitleCell","CommentsCell"]
    var comments: [Comments] = []
    var refreshControl = UIRefreshControl()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieTitle
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let getId = movieId else{
            return
        }
        
        //영화정보 dataTask 받아오기
        guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movie?id=\(getId)") else {return}
        
        let session: URLSession = URLSession(configuration:  .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error { //오류가 있을 때
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                self.movieDetail = apiResponse //response 결과를 넣어줌
                
                DispatchQueue.main.async { //메인스레드에서 실행
                    self.tableView.reloadData()
                }
                
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
        
        //한줄평 dataTask 받아오기
        guard let commentsUrl: URL = URL(string: "http://connect-boxoffice.run.goorm.io/comments?movie_id=\(getId)") else {return}
        
        let commentsSession: URLSession = URLSession(configuration:  .default)
        let commentsDataTask: URLSessionDataTask = commentsSession.dataTask(with: commentsUrl) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error { //오류가 있을 때
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let commentApiResponse: commentAPIResponse = try JSONDecoder().decode(commentAPIResponse.self, from: data)
                self.comments = commentApiResponse.comments //response 결과를 넣어줌
                
                DispatchQueue.main.async { //메인스레드에서 실행
                    self.tableView.reloadData()
                }
                
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        commentsDataTask.resume()
        
    }
    
    //MARK:- Methods
    @objc func refresh() {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController: CommentViewController = segue.destination as? CommentViewController else {return}
        nextViewController.movieTitle = movieTitle
        nextViewController.gradeImageName = imageName
        nextViewController.movieId = movieId
        
    }

}
//MARK:- UITableViewDataSource, Delegate
extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    //경계선 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2,3:
            return 1
        case 4:
            return comments.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[section], for: indexPath)
        
        guard let movieDetail = movieDetail else {
            print("movieDetail error")
            return UITableViewCell()
            
        }
        
        switch section {
        case 0:
            guard let movieInfoCell = cell as? MovieInfoTableViewCell else {
                print("movieInfoCell error")
                return UITableViewCell()
            }
            movieInfoCell.movieTitleLabel.text = movieDetail.title
            movieInfoCell.dateLabel.text = movieDetail.date
            movieInfoCell.genreDurationLabel.text = movieDetail.getGenreDuration
            movieInfoCell.dateLabel.text = movieDetail.getDate
            movieInfoCell.userRatingLabel.text = String(movieDetail.user_rating)
            movieInfoCell.audienceLabel.text = String(movieDetail.audience)
            
            let gradeImageName = movieDetail.getGradeImageName
            imageName = gradeImageName
            movieInfoCell.gradeImageView.image = UIImage(named: gradeImageName)
            
            DispatchQueue.global().async {
                //백그라운드에서 이미지 가져옴
                guard let posterImageURL: URL = URL(string: movieDetail.image) else {return}
                guard let posterImageData: Data = try? Data(contentsOf: posterImageURL) else {return}
                
                DispatchQueue.main.async {
                    //스크롤하면서 맞는 위치에 이미지를 넣게 설정
                    if let index: IndexPath = tableView.indexPath(for: movieInfoCell){
                        if index.row == indexPath.row {
                            //cell.posterImageView.image = UIImage(data: posterImageData)
                            movieInfoCell.posterImageView.image = UIImage(data: posterImageData)
                        }
                    }
                }
            }
            
        case 1:
            guard let synopsisCell = cell as? SynopsisTableViewCell else{
                print("synopsisCell error")
                return UITableViewCell()
            }
            
            synopsisCell.synopsisLabel.text = movieDetail.synopsis
//            let newSize = synopsisCell.synopsisLabel.sizeThatFits( CGSize(width: synopsisCell.synopsisLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
//            synopsisCell.synopsisLabel.frame.height = newSize.height
            
            
        case 2:
            guard let directorCell = cell as? DirectorTableViewCell else {
                print("DirectorCell error")
                return UITableViewCell()
            }
            directorCell.actorLabel.text = movieDetail.actor
            directorCell.directorLabel.text = movieDetail.director
            
//        case 3:
//            guard let titleCell = cell as? TitleTableViewCell else{
//                print("titleCell error")
//                return UITableViewCell()
//            }
            
        case 4:
            guard let commentsCell = cell as? CommentsTableViewCell else{
                print("commentsCell error")
                return UITableViewCell()
            }
           
            let comment = self.comments[indexPath.row]
            commentsCell.idLabel.text = comment.writer
            commentsCell.contentsLabel.text = comment.contents
            commentsCell.timestampLabel.text = comment.timestampToDate
            commentsCell.setStarImage(rating: comment.rating)
        default:
            break
        }
        return cell
    }
    
    //드래그해서 새로고침
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
    }
}

