//
//  ThumbnailViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class ThumbnailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var albumId: Int?
    var photoItemsInAlbum: [PhotoItem] = []
    var cachedImages: [String:UIImage] = [:]

    var selectedPhotoItem: PhotoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchNewItems(_:)), forControlEvents: .ValueChanged)
        collectionView?.addSubview(refreshControl)
        
        guard let albumId = albumId else { return }
        self.title = "Album \(albumId)"
        
        let layout = UICollectionViewFlowLayout()
        layout.setLayoutForAlbums()
        collectionView?.collectionViewLayout = layout
    }
    
    func fetchNewItems(refreshControl: UIRefreshControl) {
        // Clear our cached images & items array
        cachedImages = [:]
        photoItemsInAlbum = []
        
        guard let albumId = albumId else { return }
        Album.fetchItemsInAlbum(albumId) { items in
            self.photoItemsInAlbum = items
            self.collectionView?.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> PhotoItem? {
        let index = indexPath.item
        return photoItemsInAlbum[index]
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoItemsInAlbum.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier("Thumbnail", forIndexPath: indexPath) as! ThumbnailCollectionViewCell
        
        // Set the thumbnail image to nil
        cell.thumbnailImage?.image = nil
        cell.photoItem = itemAtIndexPath(indexPath)
        
        guard let urlString = cell.photoItem?.thumbnailURL else { return cell }

        // Check to see if we've already cached the image
        if let image = cachedImages[urlString] {
            cell.photoItem?.thumbnailImage = image
            cell.thumbnailImage?.image = image
            cell.spinner?.stopAnimating()
        // Otherwise get the image
        } else {
            PhotoManager.fetchImage(urlString) { image in
                self.cachedImages[urlString] = image
                cell.photoItem?.thumbnailImage = image
                cell.thumbnailImage?.image = image
                cell.spinner?.stopAnimating()
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Store the selected Photo Item
        selectedPhotoItem = photoItemsInAlbum[indexPath.row]
        performSegueWithIdentifier("Open Photo", sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let margins = collectionView.layoutMargins.right + collectionView.layoutMargins.left
        let cellWidth = (collectionView.frame.width / 2) - margins
        
        // This is a naive way to handle
        // TODO: determine height needed by finding apsect ratio of cell
        let roomForLabel: CGFloat = 40
        return CGSize(width: cellWidth, height: cellWidth + roomForLabel)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let photoViewController = segue.destinationViewController as? PhotoDetailViewController {
            guard let selectedPhotoItem = selectedPhotoItem else { return }
            
            // Inject the photo items for the selected album into the new view controller
            photoViewController.photoItem = selectedPhotoItem
            
            // Reset the selected items property
            self.selectedPhotoItem = nil
        }
    }
    
}
