//
//  DetailViewController.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 8/22/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailPhotoImageView: UIImageView!{
        didSet{
    detailPhotoImageView.backgroundColor = .black
            detailPhotoImageView.contentMode = .scaleAspectFit
            detailPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
            guard let photoName  = photo?.photoName else{return}
            detailPhotoImageView.image = UIImage(named: photoName)
          
            
            
        }
    }
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    



}
