//
//  ViewController.swift
//  ImageDownloader
//
//  Created by 임영선 on 2021/08/24.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var downloadTask: URLSessionDownloadTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let dataTemp: Data = try! Data(contentsOf: location)
        self.imgView.image = UIImage(data: dataTemp)
        activityIndicatorView.stopAnimating()
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        let progress: Float = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        print("prgress : \(progress)")
        progressView.setProgress(progress, animated: true)

    }
    

    @IBAction func downloadAction(_ sender: Any) {
        imgView.image = nil
        activityIndicatorView.startAnimating()
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        //downloadTask = session.downloadTask(with: URL(string:"https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!)
        
        //클로저
        downloadTask = session.downloadTask(with: URL(string:"https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!, completionHandler: {data,response,error ->Void in
            let dataTemp:Data = try! Data(contentsOf: data!)
            self.imgView.image = UIImage(data:dataTemp)
            self.activityIndicatorView.stopAnimating()

        })
        downloadTask.resume()
      
    }
    
    @IBAction func suspendAction(_ sender: Any) {
        downloadTask.suspend()
    }
    
    @IBAction func resumeAction(_ sender: Any) {
        downloadTask.resume()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        downloadTask.cancel()
        progressView.setProgress(0.0, animated: false)
        activityIndicatorView.stopAnimating()
    }
}

