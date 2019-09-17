//
//  ImageService.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation


protocol ImageProvider {
    func getImage (completion: @escaping ([Image]) -> Void)
}

class ImageService: ImageProvider {
    let urlStr = "http://jsonplaceholder.typicode.com/photos"
    lazy var session = URLSession(configuration: .default)
    
    func getImage (completion: @escaping ([Image]) -> Void){
        guard let url = URL(string: urlStr) else {
            completion ([])
            return
        }
        session.dataTask(with: url) { (dat,_,_) in
            guard let dat = dat else {
                completion ([])
                return
            }
            do {
                let reply = try JSONDecoder().decode([Image].self, from: dat)
                completion(reply)
                print(reply.count)
            }
            catch {
                print("error: = \(error)")
                completion([])
                
            }
        }.resume()
    }
}
