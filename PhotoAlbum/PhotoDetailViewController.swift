//
//  PhotoDetailViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView? {
        didSet {
            self.spinner?.hidesWhenStopped = true
        }
    }

    @IBOutlet weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.contentSize = imageView.frame.size
            scrollView?.delegate = self
            scrollView?.minimumZoomScale = 0.25
        }
    }
    
    private var imageView = UIImageView()
    
    private var image : UIImage? {
        get {
            return imageView.image
            
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            imageView.setBorderForImages()
            scrollView?.contentSize = imageView.frame.size
            self.spinner?.stopAnimating()
        }
    }
    
    var photoItem: PhotoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.addSubview(imageView)
        
        
        // pull to refresh
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchImage()
    }
    
    func fetchImage() {
        spinner?.startAnimating()
        guard let urlString = photoItem?.imageURL else { return }
        
        PhotoManager.fetchImage(urlString) { image in
            self.image = image
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
