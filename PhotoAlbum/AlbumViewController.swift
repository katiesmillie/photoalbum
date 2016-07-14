//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/7/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var allItems: [PhotoItem]?
    var albums: [Album] = []
    var cachedImages: [String:UIImage] = [:]
    var selectedAlbumId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchNewItems(_:)), forControlEvents: .ValueChanged)
        collectionView?.addSubview(refreshControl)
        
        let layout = UICollectionViewFlowLayout()
        layout.setLayoutForAlbums()
        collectionView?.collectionViewLayout = layout
    }
    
    func fetchNewItems(refreshControl: UIRefreshControl) {
        // Clear our cached images, items array, and albums array
        cachedImages = [:]
        allItems = []
        albums = []
        
        // Then fetch new items
        PhotoManager.fetchItems { items in
            let albums = Album.getAlbumsFromItems(items).sort{ $0.albumId < $1.albumId }
            self.allItems = items
            self.albums = albums
            self.collectionView?.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func albumAtIndexPath(indexPath: NSIndexPath) -> Album? {
        let index = indexPath.item
        return albums[index]
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier("Album", forIndexPath: indexPath) as! AlbumCollectionViewCell
        
        // Set the image to nil so it's not reusing the wrong image
        cell.albumImage?.image = nil
        cell.album = albumAtIndexPath(indexPath)
        
        // For now, use the first thumbnail in the album
        guard let urlString = cell.album?.photoItems?.first?.thumbnailURL else { return cell }
        
        // Check to see if we've already cached the image
        if let image = cachedImages[urlString] {
            cell.album?.coverImage = image
            cell.albumImage?.image = image
            cell.spinner?.stopAnimating()
        // Otherwise get the image
        } else {
            PhotoManager.fetchImage(urlString) { image in
                self.cachedImages[urlString] = image
                cell.album?.coverImage = image
                cell.albumImage?.image = image
                cell.spinner?.stopAnimating()
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedAlbumId = albums[indexPath.row].albumId
        performSegueWithIdentifier("Open Album", sender: nil)
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
        if let thumbnailViewController = segue.destinationViewController as? ThumbnailViewController {
            guard let selectedAlbumId = selectedAlbumId else { return }
            
            // Get the new items for the album and inject them
            let filteredItems = allItems?.filter { $0.albumId == selectedAlbumId }
            // Sort by id of the photo item
            let sortedAlbumItems = filteredItems?.sort { $0.id < $1.id }
            thumbnailViewController.albumId = selectedAlbumId
            thumbnailViewController.photoItemsInAlbum = sortedAlbumItems ?? []
            
            // Set the property storing the albumId to nil after segue
            self.selectedAlbumId = nil
        }
    }
    
}



