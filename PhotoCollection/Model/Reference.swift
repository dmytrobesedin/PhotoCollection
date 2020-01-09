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
    
    class func requestPhoto (complitionHandler : @escaping ([Photo?], Error?) -> Void)  {
        let dataTask =  request("https://jsonplaceholder.typicode.com/photos").responseJSON { (responseJSON) in
            switch responseJSON.result {
            case .failure(let error):
                print(error.localizedDescription)
                complitionHandler([],error)
            case .success(let data):
                guard let arrayJson = data as? Array<[String: Any]> else{return}
                print(data)
                var newArray = [Photo?]()
                let decoder = JSONDecoder()
                for json in arrayJson{
                    guard  let imageDate = Photo(json: json) else{return}
                    newArray.append(imageDate)
                }
                complitionHandler(newArray,nil)
            }
        }
        dataTask.resume()
    }
    class func requestImageFile(url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void)  {
        let task = request(url).responseData { (responseData) in
            switch responseData.result {
            case .failure(let error):
                completionHandler(nil,error)
                print(error.localizedDescription)
            case .success(let data):
                
                guard  let downLoadIamge = UIImage(data: data) else {return}
                completionHandler(downLoadIamge,nil)
                
            }
        }
        task.resume()
    }
}
