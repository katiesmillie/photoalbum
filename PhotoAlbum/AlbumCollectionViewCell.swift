//
//  AlbumCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/8/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView?
    @IBOutlet weak var albumTitle: UILabel?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView? {
        didSet {
            spinner?.hidesWhenStopped = true
        }
    }
    
    var album: Album? {
        didSet {
            spinner?.startAnimating()
            guard let albumId = album?.albumId else { return }
            albumTitle?.text = "Album \(albumId)"
            albumImage?.setBorderForImages()
        }
    }
  
    
}
