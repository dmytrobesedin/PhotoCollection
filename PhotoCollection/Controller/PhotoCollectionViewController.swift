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
        var photoi = Photo()
        photoi.photoName = "photo_2019-08-05 17.18.50"
        var photoii = Photo()
        photoii.photoName = "980510df9069a004852b9a9a370c6b80-quality_70Xresize_1Xallow_enlarge_0Xw_700Xh_700"
        
        return [photoImage,photoi,photoii]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setupImageView()
      
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    func setupImageView() {
        self.photoCollectionView.backgroundColor = .black
        let imageView = UIImageView(frame: self.photoCollectionView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.center = self.photoCollectionView.center
        let photoName = "980510df9069a004852b9a9a370c6b80-quality_70Xresize_1Xallow_enlarge_0Xw_700Xh_700"
        imageView.image = UIImage(named: photoName)
        self.photoCollectionView.addSubview(imageView)
    //   self.view.addSubview(imageView)
        
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
        
        let photoIndex = photo[indexPath.row] 
        
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else{return}
            viewController.photo = photoIndex
        self.navigationController?.pushViewController(viewController, animated: false)
        self.dismiss(animated: false, completion:  nil)
        
        
        
    }

}
