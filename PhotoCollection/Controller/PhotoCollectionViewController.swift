//
//  PhotoCollectionViewController.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 8/22/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit



class PhotoCollectionViewController: UICollectionViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photo: [Photo] = {
         var photoImage = Photo()
        photoImage.photoName = "photo-1534067783941-51c9c23ecefd.jpeg"
        return [photoImage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }


    // MARK: UICollectionViewDataSource


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
        let photoList = photo[indexPath.row]
        cell.photo = photoList
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") else{return}
        self.navigationController?.pushViewController(viewController, animated: false)
        self.dismiss(animated: false, completion:  nil)
        
        
        
    }

}
