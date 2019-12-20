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
    
    var photo =  [Photo?]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
   
       
         downloadPhoto()
         spacingForCollictionCell()
       
    
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
    

    // MARK: - Download Photo
    func downloadPhoto()  {

        request("http://jsonplaceholder.typicode.com/photos").responseJSON { (responseJSON) in
            switch responseJSON.result {
            case .success(let value):
                guard let arrayJson = value as? Array<[String: Any]> else{return}
                var newPhotoList = [Photo]()
                for json in arrayJson{
                    guard let photoPost = Photo(json: json) else{return}
                    newPhotoList.append(photoPost)
                }
                self.photo = newPhotoList
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }

            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
        


    
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
        let photoItem = photo[indexPath.row]
            cell.photo = photoItem
        return cell
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoIndex = photo[indexPath.row]
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else{return}
            viewController.photo = photoIndex
        self.navigationController?.pushViewController(viewController, animated: false)
        self.dismiss(animated: false, completion:  nil)
    }
}









