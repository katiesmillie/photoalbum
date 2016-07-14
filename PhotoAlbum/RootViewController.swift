//
//  RootViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var currentViewController: UIViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingUI()
        showMainUI()
    }
    
    
    func embedViewController(viewController: UIViewController) {
        removePreviousViewController()
        addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        let views = ["view": viewController.view]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        viewController.didMoveToParentViewController(self)
        currentViewController = viewController
    }
    
    
    private func removePreviousViewController() {
        guard let currentViewController = currentViewController else { return }
        currentViewController.willMoveToParentViewController(nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParentViewController()
        
    }
    
    internal func showLoadingUI() {
        let storyboard = UIStoryboard(name: "Loading", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? LoadingViewController {
            embedViewController(viewController)
        }
    }
    
    internal func showMainUI() {

        // Fetch all json items and create albums
        // Inject the items and the albums into the AlbumViewController

        PhotoManager.fetchItems { items in
            let albums = Album.getAlbumsFromItems(items).sort{ $0.albumId < $1.albumId }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let navController = storyboard.instantiateInitialViewController() as? UINavigationController, viewController = navController.topViewController as? AlbumViewController {
                viewController.allItems = items
                viewController.albums = albums
                self.embedViewController(navController)
            }
        }
    }
    
}

