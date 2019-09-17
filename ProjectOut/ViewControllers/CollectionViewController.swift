//
//  CollectionViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/13/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var imageViewModel: ImageViewModel! {
        didSet {
            imageViewModel.delegate = self as? ViewModelDelegate
        }
    }
    lazy var collectionView: UICollectionView = {
        let config = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: config)
        view.delegate = self
        view.dataSource = self
        return view
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageViewModel = ImageViewModel(ImageService())
        imageViewModel.download()
        definesPresentationContext = true
        buildCollectionView()
    }
    func buildCollectionView(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
}

extension CollectionViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageViewModel.images.count)
        return imageViewModel.images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        let imag = imageViewModel.images[indexPath.row]
        cell.image = imag
        return cell
    }
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3.0 - 9.0
        return CGSize(width: width, height: width)
    }
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        return
    //    }
}
