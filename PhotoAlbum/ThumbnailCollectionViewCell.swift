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
    
    
    var photoItem: PhotoItem? {
        didSet {
            guard let photoTitle = photoItem?.title else { return }
            title?.text = "Album \(photoTitle)"
        }
    }

    
}
