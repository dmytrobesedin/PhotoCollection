//
//  Photo.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 8/27/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var albumId: Int
    var id: Int
    var url: String
    var thumbnailUrl: String
    enum PhotoKeys:String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    
    
    init?(json: [String: Any]) {
        guard
            let albumId = json["albumId"] as? Int,
            let id = json["id"] as? Int,
            let url = json["url"] as? String,
            let thumbnailUrl = json["thumbnailUrl"] as? String
            else {
                return nil
        }
        
        self.albumId = albumId
        self.id = id
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
