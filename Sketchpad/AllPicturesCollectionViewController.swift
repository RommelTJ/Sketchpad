//
//  AllPicturesCollectionViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/5/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

private let reuseIdentifier = "pictureCollectionCell"

class AllPicturesCollectionViewController: UICollectionViewController {

    private var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let pictures = try? context.fetch(Picture.fetchRequest()) as? [Picture] {
                if let pics = pictures {
                    self.pictures = pics
                    collectionView?.reloadData()
                }
            }
        }
    }
    
    func getPictures() {
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PictureCollectionViewCell {
            let picture = pictures[indexPath.row]
            cell.pictureLabel.text = picture.name
            if let imageData = picture.image {
                cell.pictureImageView.image = UIImage(data: imageData)
            }
            return cell
        }
        return UICollectionViewCell()
    }

}
