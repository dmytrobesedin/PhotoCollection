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
            guard let stringUrl = photo?.url else {return}
            guard let url = URL(string:stringUrl) else {return}
            guard let data = try? Data(contentsOf: url) else{return}
            guard let image = UIImage(data: data) else {return}
            photoImageView.image = image
        }
        
    }
    func defaultConfigure() {
       
        guard let url = URL(string:"photo-1534067783941-51c9c23ecefd") else {return}
        guard let data = try? Data(contentsOf: url) else{return}
        guard let image = UIImage(data: data) else {return}
        photoImageView.image = image
    }
}
