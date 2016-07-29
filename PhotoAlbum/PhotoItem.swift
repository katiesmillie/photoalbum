//
//  PhotoItem.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/8/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation
import UIKit

public struct PhotoItem {
    let albumId: Int
    let id: Int
    let title: String
    let imageURL: String
    let thumbnailURL: String
    var fullImage: UIImage?
    var thumbnailImage: UIImage?
    
    
    // Set the Images as .NotDownloaded and nil by default
    public init(albumId: Int, id: Int,title: String, imageURL: String, thumbnailURL: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
    }
}

public func ==(lhs: PhotoItem, rhs: PhotoItem) -> Bool {
    return (lhs.albumId == rhs.albumId
        && lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.thumbnailURL == rhs.thumbnailURL
        && lhs.imageURL == rhs.imageURL)
}

extension PhotoItem: Equatable {}
