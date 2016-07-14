//
//  PhotoAlbumTests.swift
//  PhotoAlbumTests
//
//  Created by Katie Smillie on 7/7/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import XCTest
@testable import PhotoAlbum


class PhotoAlbumTests: XCTestCase {
    
    let photoItem1 = PhotoItem(albumId: 2, id: 56, title: "reprehenderit est deserunt velit ipsam", imageURL: "http://placehold.it/150/dff9f6",  thumbnailURL: "http://placehold.it/600/771796")
    let photoItem2 = PhotoItem(albumId: 3, id: 30, title: "reprehenderit est deserunt velit ipsam", imageURL: "http://placehold.it/150/dff9f6",  thumbnailURL: "http://placehold.it/600/771796")
    
    let sampleData: [[String:AnyObject]] = [["albumId":2,"id":56,"title":"reprehenderit est deserunt velit ipsam","url":"http://placehold.it/150/dff9f6","thumbnailUrl":"http://placehold.it/600/771796"]]
    
    var photoItems: [PhotoItem] = []
    
    override func setUp() {
        super.setUp()
        photoItems += [photoItem1, photoItem2]
    }
    
    
    func testDecodeItem() {
        let photoItemsDecoded = PhotoManager.decodeItems(sampleData)
        XCTAssertEqual(photoItemsDecoded, [photoItem1])
        XCTAssertNotEqual(photoItemsDecoded, [photoItem2])
    }
    
 
    func testGetAlbumsFromItems() {
        let fetchedAlbums = Album.getAlbumsFromItems(photoItems)
        let fetchedAlbumIds = fetchedAlbums.map { $0.albumId! }
        let sortedFetchedAlbumIds = fetchedAlbumIds.sort( < )
        let albumdIds = [2,3]
        XCTAssertEqual(albumdIds, sortedFetchedAlbumIds)

    }
  
    
    
}
