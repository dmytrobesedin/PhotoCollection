//
//  PhotoCollectionViewCell.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 8/22/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: Photo?{
        didSet{
            guard let namePhoto = self.photo?.photoName else{return}
            photoImageView.image = UIImage(named: namePhoto)
        }
    }
}
