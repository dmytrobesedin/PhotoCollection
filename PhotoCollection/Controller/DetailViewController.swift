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
            
                detailPhotoImageView.contentMode = .scaleAspectFit
                detailPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
                guard let stringUrl = photo?.url else {return}
                guard let url = URL(string:stringUrl) else {return}
                guard let data = try? Data(contentsOf: url) else{return}
                guard let image = UIImage(data: data) else {return}
                self.detailPhotoImageView.image = image
     }
    }
    var photo: Photo?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
