//
//  RootViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMainUI()
    }
    
    internal func showMainUI() {        
        // Fetch all items and create albums before loading the album view controller
        // TODO: Create loading state
        PhotoManager.fetchItems { items in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                let albums = Album.albumsWithinItems(items).sort{ $0.albumId < $1.albumId }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let navController = storyboard.instantiateInitialViewController() as? UINavigationController, viewController = navController.topViewController as? AlbumViewController {
                    viewController.allItems = items
                    viewController.albums = albums
                    self.presentViewController(navController, animated: true, completion: nil)
                }
            }
        }
    }
    
}

