//
//  PhotoItem.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/8/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation
import UIKit

public enum Status {
    case NotDownloaded
    case Downloaded
}

public struct Image {
    var status: Status?
    let image: UIImage?
    
    init(status: Status?, image: UIImage?) {
        self.status = status
        self.image = image
    }
}


public struct PhotoItem {
    let albumId: Int?
    let id: Int?
    let title: String?
    let thumbnailURL: String?
    let imageURL: String?
    var thumbnailImage: Image?
    var fullImage: Image?
    
    // Set the Images as .NotDownloaded and nil by default
    public init(albumId: Int, id: Int,title: String, thumbnailURL: String, imageURL: String, thumbnailImage: Image? = Image(status: .NotDownloaded, image: nil), fullImage: Image? = Image(status: .NotDownloaded, image: nil) ) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.imageURL = imageURL
        self.thumbnailImage = thumbnailImage
        self.fullImage = fullImage
    }
    
    
}