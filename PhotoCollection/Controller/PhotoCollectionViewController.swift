//
//  PhotoCollectionViewController.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 8/22/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit
import Alamofire



class PhotoCollectionViewController: UICollectionViewController{
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    // store task (calling API) of getting each photo
    var dataTasks : [DataRequest] = []
    
    //let photoID = [1,2,3,45]
    var photo =  [Photo?]()
    var photoID = [Int?]()
    
    
    
    
    
    
//    var baseURL: String {
//        return "http://jsonplaceholder.typicode.com/photos/?"
//    }
//
//    // current count photo
//
//
//    // total photo
//    let totalPhoto = 18
//
//    var url1 : URL {
//        get{
//            if let newUrl = URL(string: "\(baseURL)start=\(photoID)&limit=\(totalPhoto)") {
//                return newUrl}
//            return URL(string: baseURL)!
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.prefetchDataSource = self
       spacingForCollictionCell()
       getPhotoId()
       
       // downloadPhoto()
      //  pagitionPhoto()
    }
    
    
    
    
    func getPhotoId() {
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/photos") else {return}
        let dataTask = request(url).responseJSON { (response) in
            switch response.result {
            case .failure( let error):
                print(error.localizedDescription)
            case .success(let value):
                guard let arrayJson = value as? Array<[String: Any]> else{return}
                var newPhotoIdList = [Int]()
                for json in arrayJson{
                    guard let photoPost = Photo(json: json) else{return}
                    guard let photoId = photoPost.id else{return}
                    newPhotoIdList.append(photoId)
                }
                self.photoID = newPhotoIdList
                }
            }
        
        dataTask.resume()
        dataTasks.append(dataTask)
    }
    // MARK: - Spacing cell in collectionview
    func spacingForCollictionCell(){
        guard var screenSize: CGRect = UIScreen.main.bounds else{return}
        guard var screenWidth: CGFloat = screenSize.width else{return}
        guard var screenHeight: CGFloat = screenSize.height else{return}
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        photoCollectionView.collectionViewLayout = layout
    }
    
    
    
    func fetchPhoto(ofIndex index:Int){
        let photoId = photoID[index]
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/photos/\(photoId)") else {return}
        
    
        let dataTask = request(url).responseJSON { (response) in
            switch response.result {
            case .failure( let error):
                print(error.localizedDescription)
            case .success(let value):
                guard let arrayJson = value as? [String: Any] else{return}
                    guard let photoPost = Photo(json: arrayJson) else{return}
                    self.photo[index] = photoPost
                   // newPhotoList.append(photoPost)
              //  self.photo = newPhotoList
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: index, section: 1)
                    if self.photoCollectionView.indexPathsForVisibleItems.contains(indexPath)  ?? false{
                         self.photoCollectionView.reloadItems(at: [IndexPath(row: index, section: 1)])
                    }
                  //  self.photoCollectionView.reloadData()
                }
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
    
    func cancelFetchPhoto(ofIndex index:Int)  {
    let photoId = photoID[index]
    guard let url = URL(string: "http://jsonplaceholder.typicode.com/photos/\(photoId)") else {return}
    guard let dataTaskIndex =   dataTasks.lastIndex(where:  { task in
        task.request?.url == url }) else  {return}
        let dataTask =  dataTasks[dataTaskIndex]
        dataTask.cancel()
        dataTasks.remove(at: dataTaskIndex)
    }
//
//    // MARK: - Pagition array with photo
//    func pagitionPhoto()  {
//        guard let url = URL(string: "http://jsonplaceholder.typicode.com/photos/\(index).json") else {return}
//
//        let photoRequest =  request(url)
//            photoRequest.responseJSON(completionHandler: { (responseJson) in
//                switch responseJson.result {
//                case .failure(let error):
//                    print(error)
//                case .success(let value):
//                    guard let arrayJson = value as? Array<[String: Any]> else{return}
//                    var newPhotoList = [Photo]()
//                    for json in arrayJson{
//                        guard let photoPost = Photo(json: json) else{return}
//                        newPhotoList.append(photoPost)
//                    }
//                    self.photo = newPhotoList
//
//                  //  self.photoCount += self.totalPhoto
//
//                    DispatchQueue.main.async {
//                        self.photoCollectionView.reloadData()
//                    }
//                }
//        })
//
//    }
//
//    // MARK: - Download Photo without pagitation
//    func downloadPhoto()  {
//
//        request("http://jsonplaceholder.typicode.com/photos").responseJSON { (responseJSON) in
//            switch responseJSON.result {
//            case .success(let value):
//                guard let arrayJson = value as? Array<[String: Any]> else{return}
//                var newPhotoList = [Photo]()
//                for json in arrayJson{
//                    guard let photoPost = Photo(json: json) else{return}
//                    newPhotoList.append(photoPost)
//                }
//                self.photo = newPhotoList
//                DispatchQueue.main.async {
//                    self.photoCollectionView.reloadData()
//                }
//
//            case .failure(let error): print(error.localizedDescription)
//            }
//        }
//    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photo.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else{return UICollectionViewCell()}
        
        
        
        
//         let photoList = photo[indexPath.row]
//        if indexPath.row == self.photo.count{
//            pagitionPhoto()
//            cell.photo = photoList
//            return cell
//        }
//        cell.photo = photoList
        let photoItem = photo[indexPath.row]
            cell.photo = photoItem
    
        self.fetchPhoto(ofIndex: indexPath.row)
        
        return cell
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoIndex = photo[indexPath.row]
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else{return}
            viewController.photo = photoIndex
        self.navigationController?.pushViewController(viewController, animated: false)
        self.dismiss(animated: false, completion:  nil)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////        let currentOfset = collectionView.contentOffset.y
////        let maxOfSet = collectionView.contentSize.height - collectionView.frame.size.height
////        if maxOfSet - currentOfset <= 40 /*indexPath.row == photo.count - 1*/{
////            pagitionPhoto()
////        }
////       let lastPhoto = photo.count - 1
////        if indexPath.row == photo.count - 1 {
////            if totalPhoto > photo.count{
////                pagition()
////            }
////        }
//
//    }

    
    
}

extension PhotoCollectionViewController: UICollectionViewDataSourcePrefetching {

        func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
            for indexPath in indexPaths {
                self.fetchPhoto(ofIndex: indexPath.row)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
            
            for indexPath in indexPaths {
                self.cancelFetchPhoto(ofIndex: indexPath.row)
            }
        }
    
    }






