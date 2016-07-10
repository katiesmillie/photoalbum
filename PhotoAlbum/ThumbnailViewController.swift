//
//  ThumbnailViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class ThumbnailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    var photoItems: [PhotoItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func itemAtIndexPath(indexPath: NSIndexPath) -> PhotoItem? {
        let index = indexPath.item
        return photoItems[index]
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier("Thumbnail", forIndexPath: indexPath) as! ThumbnailCollectionViewCell
        cell.photoItem = itemAtIndexPath(indexPath)
        
        guard let thumbnailStatus = cell.photoItem?.thumbnailImage?.status  else { return cell }
        
        switch thumbnailStatus {
        case .NotDownloaded:
            guard let urlString = cell.photoItem?.thumbnailURL else { return cell }
            PhotoManager.fetchImage(urlString) { image in
                cell.photoItem?.thumbnailImage = image
                cell.photoItem?.thumbnailImage?.status = .Downloaded
                cell.thumbnailImage?.image = image.image
            }
        case .Downloaded:
            cell.thumbnailImage?.image = cell.photoItem?.thumbnailImage?.image
        }
        
        return cell
    }
    

    
}
