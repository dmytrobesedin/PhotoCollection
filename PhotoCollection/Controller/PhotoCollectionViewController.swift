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
    
   public var photo =  [Photo?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        Reference.requestPhoto(complitionHandler:handleImageResponse(imageData:error:))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        spacingForCollictionCell()
    }
    
    // MARK: - Spacing cell in collectionview
  private  func spacingForCollictionCell(){
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
    
    // MARK: - HandleImageResponse
 private   func handleImageResponse(imageData:[Photo?], error:Error?)  {
        self.photo = imageData
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
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
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell
            else{return UICollectionViewCell()}
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









