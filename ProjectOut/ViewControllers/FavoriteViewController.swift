//
//  FavoriteViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, ImageViewModelDelegate {
    var imageViewModel: ImageViewModel!
    
    func updateView() {
        DispatchQueue.main.async {
            self.favCollectionView.reloadData()
        }
    }
    lazy var favCollectionView: UICollectionView = {
        let config = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: config)
        view.delegate = self
        view.dataSource = self
        view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageViewModel = ImageViewModel(ImageService())
        buildFavCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageViewModel.getCoreImage()
        self.favCollectionView.reloadData()
    }

    func buildFavCollectionView(){
        
        favCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favCollectionView)
        NSLayoutConstraint.activate([
            favCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            favCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            favCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            favCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        NotificationCenter.default.addObserver(forName: Notification.Name("Core"), object: self, queue: .main) {[unowned self] _ in
            self.favCollectionView.reloadData()
        }
        
    }
}
extension FavoriteViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel.favoriteImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        let imag = imageViewModel.favoriteImages[indexPath.row]
        cell.image = imag
        return cell
    }
}

typealias UICollectionViewAppearanceDelegate = UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewAppearanceDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3.0 - 9.0
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let cimage = imageViewModel.favoriteImages[indexPath.row]
        detailVC.imageViewModel = imageViewModel
        imageViewModel.currentImage = cimage
        show(detailVC, sender: nil)
    }
    
}

