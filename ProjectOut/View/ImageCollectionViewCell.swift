//
//  ImageCollectionViewCell.swift
//  ProjectOut
//
//  Created by Consultant on 9/15/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var cacheManager = CacheManager()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    var image: Image? {
        didSet {
            let url = (image?.thumbnailUrl)!
            cacheManager.downloadImage(url) {[unowned self] dat in
                if let data = dat {
                    let imag = UIImage(data: data)
                    self.imageView.image = imag
                }
            }
            
        }
    }
//        set {
//            imageView.image = newValue
//        }
//        get {
//            return imageView.image
//        }
//    }
    override init(frame: CGRect) {
        super .init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    static let identifier = "ImageCollectionViewCell"
}
