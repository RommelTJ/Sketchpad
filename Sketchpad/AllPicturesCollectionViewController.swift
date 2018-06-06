//
//  AllPicturesCollectionViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/5/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class AllPicturesCollectionViewController: UICollectionViewController {

    private var pictures: [Picture] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }
    
    func getPictures() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let pictures = try? context.fetch(Picture.fetchRequest()) as? [Picture] {
                if let pics = pictures {
                    self.pictures = pics
                    collectionView?.reloadData()
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCollectionCell", for: indexPath) as? PictureCollectionViewCell {
            let picture = pictures[indexPath.row]
            cell.pictureLabel.text = picture.name
            if let imageData = picture.image {
                cell.pictureImageView.image = UIImage(data: imageData)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = pictures[indexPath.row]
        performSegue(withIdentifier: "viewDetailSegue", sender: picture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            if let picture = sender as? Picture {
                detailVC.picture = picture
            }
        }
    }

}
