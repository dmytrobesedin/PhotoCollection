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
  public  var photo: Photo?{
        didSet{
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            guard let stringUrl = photo?.url else {return}
            guard let url = URL(string:stringUrl) else {return}
            guard let data = try? Data(contentsOf: url) else{return}
            guard let image = UIImage(data: data) else {return}
            photoImageView.image = image
        }
    }
}
