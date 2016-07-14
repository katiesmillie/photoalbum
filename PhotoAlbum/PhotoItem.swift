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
    let albumId: Int?
    let id: Int?
    let title: String?
    let imageURL: String?
    let thumbnailURL: String?
    var fullImage: UIImage?
    var thumbnailImage: UIImage?
    
    
    // Set the Images as .NotDownloaded and nil by default
    public init(albumId: Int, id: Int,title: String, imageURL: String, thumbnailURL: String, fullImage: UIImage? = nil, thumbnailImage: UIImage? = nil) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.fullImage = fullImage
        self.thumbnailImage = thumbnailImage
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


// TODO: Cache photos and keep track of their
// state using custom Image type

public struct Image {
    public enum Status {
        case NotDownloaded
        case Downloaded
        case Failed
    }
    
    var status: Status?
    let image: UIImage?
    
    init(status: Status?, image: UIImage?) {
        self.status = status
        self.image = image
    }
}