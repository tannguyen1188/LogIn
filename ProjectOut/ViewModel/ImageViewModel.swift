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
    func updateView()
}

class ImageViewModel {
    let imageService: ImageProvider

    init(_ imageService: ImageProvider) {
        self.imageService = imageService
    }
    weak var delegate: ViewModelDelegate?
    var images = [Image]() {
        didSet {
            delegate?.updateView()
        }
    }
    func download() {
        imageService.getImage { [unowned self] ims in
            self.images = ims
            print("Image count: \(self.images.count)")
        }
    }
}



