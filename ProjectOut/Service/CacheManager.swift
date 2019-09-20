//
//  CacheManager.swift
//  ProjectOut
//
//  Created by Consultant on 9/14/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation

//protocol CacheService {
//    func downloadImage (_ thumbnailURL: String, completion: @escaping (Data?) -> Void)
//}

let cacheManager = CacheManager.shared

final class CacheManager {
    
    static let shared = CacheManager()
    private init(){}
    let cache = NSCache<NSString, NSData>()
    
    let session = URLSession(configuration: .default)
    
    func downloadImage( from urlS: String, completion: @escaping (Data?) -> Void) {
        // check if images exist on cache
        if let dataObject = cache.object(forKey: urlS as NSString){
            completion(dataObject as Data)
            return
        }
        // check if url exists
        guard let url = URL(string: urlS) else {
            completion(nil)
            return
        }
        session.dataTask(with: url) { [unowned self] (dat, _, err) in
            if err != nil {
                completion (nil)
                return
            }
            if let data = dat {
                self.cache.setObject(data as NSData, forKey: urlS as NSString)
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            
            }.resume()
        
    }
    
}
