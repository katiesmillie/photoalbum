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
    var selectedAlbumItems: [PhotoItem]?

    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Add a pull to refresh and fetch new images
    }
    
    
    func fetchNewImages() {
        PhotoManager.fetchItems { items in
            let items = PhotoManager.decodeItems(items)
            let albums = Album.albumsFromItems(items).sort{ $0.albumId < $1.albumId }
            self.allItems = items
            self.albums = albums
        }
        collectionView?.reloadData()
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
        var album = albumAtIndexPath(indexPath)
        cell.album = album
        
        //???: Downloaded case is never called because setting the status on the album property in the cell which is getting recreated and copied each time the view loads
        // Need to update the albums property on self with updated albums
        
         
        guard let status = cell.album?.coverImage?.status else {return cell }
        switch status {
        case .NotDownloaded:
            
            // For now, use the first thumbnail in the album
            // TODO: Create a custom image, 4x4 of first 4 items in album
            guard let urlString = cell.album?.photoItems?.first?.thumbnailURL else { return cell }
            PhotoManager.fetchImage(urlString) { image in
                album?.coverImage = image
                album?.coverImage?.status = .Downloaded
                cell.albumImage?.image = image.image
            }
        case .Downloaded:
            cell.albumImage?.image = cell.album?.coverImage?.image
        }
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let album = albums[indexPath.row]
        
        // Filter and sort the photo items in the selected album
        let filteredItems = allItems?.filter { $0.albumId == album.albumId }
        selectedAlbumItems = filteredItems?.sort { $0.id < $1.id }
        performSegueWithIdentifier("Open Album", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let thumbnailViewController = segue.destinationViewController as? ThumbnailViewController {
            guard let selectedAlbumItems = selectedAlbumItems else { return }
            
            // Inject the photo items for the selected album into the new view controller
            thumbnailViewController.photoItems = selectedAlbumItems
            
            // Reset the selected items property
            self.selectedAlbumItems = nil
        }
    }
    
}



