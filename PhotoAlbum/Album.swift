//
//  Album.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation
import UIKit


public struct Album {
    let albumId: Int?
    let photoItems: [PhotoItem]?
    var coverImage: UIImage?
    
    
    // Set coverImage as .NotDownloaded and nil by default
    init(albumId: Int, photoItems: [PhotoItem], coverImage: UIImage? = nil) {
        self.albumId = albumId
        self.photoItems = photoItems.sort{ $0.id < $1.id }
        self.coverImage = coverImage
    }
    
    
    static func getAlbumsFromItems(items: [PhotoItem]) -> [Album] {
        
        // Find a unique set of album ids from all items
        let albumIDs = items.flatMap { $0.albumId }
        let uniqueAlbumsSet = Set(albumIDs)
        let uniqueAlbumID = uniqueAlbumsSet.flatMap { Int($0) }
        
        
        // For each album id, get all photo items
        // Then create an ablum, and add it to the array of albums
        var albums:[Album] = []
        for albumId in uniqueAlbumID {
            let filteredItems = items.filter { $0.albumId! == Int(albumId) }
            albums += [Album(albumId: albumId, photoItems: filteredItems)]
        }
        return albums
    }
    
    static func fetchItemsInAlbum(albumId: Int, completion: ([PhotoItem])->()) {
        
        PhotoManager.fetchItems { items in
            // Filter the items for the album id
            let filteredItems = items.filter { $0.albumId == albumId }
            // Sort by id of the photo item
            let selectedAlbumItems = filteredItems.sort { $0.id < $1.id }
            completion(selectedAlbumItems)
        }
       }
}
