//
//  ThumbnailCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView?
    @IBOutlet weak var title: UILabel?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView? {
        didSet {
            spinner?.hidesWhenStopped = true
        }
    }
    
    var photoItem: PhotoItem? {
        didSet {
            spinner?.startAnimating()
            guard let photoTitle = photoItem?.title else { return }
            title?.text = "Album \(photoTitle)"
        }
    }

    
}
