//
//  ImageViewModel.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    var imageViewModel: ImageViewModel! {set get}
}
class ImageViewModel {
    let imageService: ImageProvider

    init(_ imageService: ImageProvider) {
        self.imageService = imageService
    }
    var images = [Image]()
    func download() {
        self.imageService.getImage { [unowned self] ims in
            self.images = ims
            
        }
    }
    var cacheManager = CacheManager()
}



