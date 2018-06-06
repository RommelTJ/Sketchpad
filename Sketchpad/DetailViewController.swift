//
//  DetailViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/5/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = picture?.name
        
        if let imageData = picture?.image {
            detailImageView.image = UIImage(data: imageData)
        }
    }

    @IBAction func deleteTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let picToBeDeleted = picture {
                context.delete(picToBeDeleted)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        if let image = detailImageView.image {
            let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(shareVC, animated: true, completion: nil)
        }
    }
    
}
