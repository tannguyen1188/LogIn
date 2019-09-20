//
//  ImageViewModel.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import Foundation

protocol ImageViewModelDelegate: class {
    var imageViewModel: ImageViewModel! {get set}
    func updateView()
}

class ImageViewModel {
    
    let imageService: ImageProvider

    init(_ imageService: ImageProvider) {
        self.imageService = imageService
    }
    let coreManager = CoreManager()
    
    weak var delegate: ImageViewModelDelegate?
    
    var images = [Image]() {
        didSet {
            delegate?.updateView()
        }
    }
    var currentImage: Image!
    
    var favoriteImages = [Image]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("Core"), object: self)
        }
    }
    func download() {
        imageService.getImage { [unowned self] ims in
            self.images = ims
            print("Image count: \(self.images.count)")
        }
    }
    func getCoreImage(){
        favoriteImages = coreManager.reload()
    }
}



