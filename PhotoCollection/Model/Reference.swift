//
//  Reference.swift
//  PhotoCollection
//
//  Created by Дмитрий Беседин on 9/4/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//
 
import Foundation
import Alamofire
import UIKit


class Reference {
    
    
    enum EndPoint{
        
        case urlHttp
        case urlHttpForId(Int)
        case urlHttps
    

    
        var url: URL {
            return URL(string: self.stringUrl)!
        
        }
        var stringUrl:String {
            switch self {
            case .urlHttp:
                return "http://jsonplaceholder.typicode.com/photos"
            case .urlHttps:
                return "https://jsonplaceholder.typicode.com/photos"
            case .urlHttpForId(let id):
                return "http://jsonplaceholder.typicode.com/photos/\(id)"
            default:
                return "error"
            }
        }
        
    
    }
 
    
    


    

   

}
