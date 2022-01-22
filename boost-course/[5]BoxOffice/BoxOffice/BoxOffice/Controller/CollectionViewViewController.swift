//
//  CollectionViewViewController.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import UIKit

class CollectionViewViewController: UIViewController {

    //MARK:- @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: properties
    let cellIdentifier: String = "movieCell"
    var movies: [Movies] = []
    var orderTypeString: String {
        switch orderType {
        case 0:
            return "예매율"
        case 1:
            return "큐레이션"
        default:
            return "개봉일"
        }
    }
    var refreshControl = UIRefreshControl()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = orderTypeString
        
        //새로고침
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       requestMovie(orderType: orderType)
        navigationItem.title = orderTypeString
    }
    
    //MARK:- methods
    @objc func refresh() {
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: MovieDetailViewController = segue.destination as? MovieDetailViewController else {return}
        
        guard let cell: CollectionViewCell = sender as? CollectionViewCell else {return}
        nextViewController.movieId = cell.movieId //선택한 영화의 id 보냄
        nextViewController.movieTitle = cell.movieTitleLabel.text
    }
    
    func requestMovie(orderType: Int) {
        guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType)") else {return}
        
        let session: URLSession = URLSession(configuration:  .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error { //오류가 있을 때
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.movies = apiResponse.movies //response 결과를 넣어줌
                
                DispatchQueue.main.async { //메인스레드에서 실행
                    self.collectionView.reloadData()
                }
                
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    //actionSheet
    func showAlertController() {
        let alertController: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let reservaionRateAction: UIAlertAction = UIAlertAction(title: "예매율", style: .default, handler: {(action: UIAlertAction) in
            orderType = 0
            self.requestMovie(orderType: orderType)
            self.navigationItem.title = self.orderTypeString
        })
        let qurationAction: UIAlertAction = UIAlertAction(title: "큐레이션", style: .default, handler: {(action: UIAlertAction) in
            orderType = 1
            self.requestMovie(orderType: orderType)
            self.navigationItem.title = self.orderTypeString
        })
        let openDateAction: UIAlertAction = UIAlertAction(title: "개봉일", style: .default, handler: {(action: UIAlertAction) in
            orderType = 2
            self.requestMovie(orderType: orderType)
            self.navigationItem.title = self.orderTypeString
        })
        
//        //collectionView와 orderType 공유
//        guard let vc = storyboard?.instantiateViewController(identifier:"collectionViewVC") as? CollectionViewViewController else {
//            print("navigation vc error")
//            return
//
//        }
//        vc.orderType = self.orderType
//        self.navigationController?.pushViewController(vc, animated: true)
        
        alertController.addAction(cancelAction)
        alertController.addAction(reservaionRateAction)
        alertController.addAction(qurationAction)
        alertController.addAction(openDateAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func showActionSheet(_ sender: Any) {
        self.showAlertController()
    }

}

extension CollectionViewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CollectionViewCell else {
            print("collectionViewCell error")
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.movieId = movie.id
        cell.secondLabel.text = movie.ReservationGradeRate
        cell.movieTitleLabel.text = movie.title
        cell.dateLabel.text = movie.date
        
        let gradeImageName = movie.getGradeImageName
        cell.gradeImageView.image = UIImage(named: gradeImageName)
        
        DispatchQueue.global().async {
            //백그라운드에서 이미지 가져옴
            guard let posterImageURL: URL = URL(string: movie.thumb) else {return}
            guard let posterImageData: Data = try? Data(contentsOf: posterImageURL) else {return}
            
            DispatchQueue.main.async {
                //스크롤하면서 맞는 위치에 이미지를 넣게 설정
                if let index: IndexPath = collectionView.indexPath(for: cell){
                    if index.row == indexPath.row {
                        cell.posterImageView.image = UIImage(data: posterImageData)
                    }
                }
            }
        }
        return cell
    }
    
    //드래그해서 새로고침
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
    }
}


//MARK:- UICollectionViewDelegateFlowLayout
extension CollectionViewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = collectionView.frame.width
       
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        
        let cellWidth = (width-widthPadding) / itemsPerRow 
        let cellHeight = cellWidth + 170
       
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInsets.left
    }
}
