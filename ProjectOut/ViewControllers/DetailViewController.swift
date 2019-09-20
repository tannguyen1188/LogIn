//
//  DetailViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/17/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ImageViewModelDelegate{
    func updateView() {
        fatalError("not implement")
        
    }
    
    var detailImage: UIImageView!
    var imageViewModel: ImageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // imageViewModel = ImageViewModel(ImageService())
        loadImageView()
        favoriteButton()
    }
    
    func loadImageView() {
        detailImage = UIImageView()
        view.backgroundColor = .white
        guard let image = imageViewModel.currentImage else {
            return
        }
        let url = image.url
        cacheManager.downloadImage(from: url) { [unowned self] dat in
            if let data = dat {
                let imge = UIImage(data: data)
                self.detailImage.image = imge
            }
        }
        view.addSubview(detailImage)
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
     //   detailImage.contentMode = .scaleAspectFit
    }
    func favoriteButton(){
        let favButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveToCore))
        let unfavButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(deleteFromCore))
    
        // === checks the memory address
        if let im = imageViewModel.currentImage, imageViewModel.favoriteImages.contains(where: { $0 == im }) {
            navigationItem.rightBarButtonItem = unfavButton
        } else {
            navigationItem.rightBarButtonItem = favButton
        }
    }
    
    
    
    @objc func saveToCore () {
        guard let favoriteImage = imageViewModel.currentImage else {
            return
        }
        imageViewModel.coreManager.save(favoriteImage)
        imageViewModel.favoriteImages.append(favoriteImage)
        favoriteButton()
    }
    @objc func deleteFromCore(){
        
        guard let favoriteImage = imageViewModel.currentImage else {
            return
        }
        imageViewModel.favoriteImages.removeAll(where: {$0 == favoriteImage})
        imageViewModel.coreManager.remove(favoriteImage)
        favoriteButton()
    }
}

