//
//  PhotoDetailViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/10/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var photoItem: PhotoItem?
    
    @IBOutlet weak var photoTitle: UILabel?
    @IBOutlet weak var spinner: UIActivityIndicatorView? {
        didSet {
            spinner?.hidesWhenStopped = true
        }
    }

    @IBOutlet weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.contentSize = imageView.frame.size
            scrollView?.delegate = self
            scrollView?.minimumZoomScale = 1
            scrollView?.maximumZoomScale = 3
        }
    }
    
    private var imageView = UIImageView()
    
    private var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.setBorderForImages()
            
            // resize the image to the scroll view's width
            guard let imageWidth = scrollView?.frame.width else { return }
            imageView.frame = CGRectMake(0, 0, imageWidth, imageWidth)
            scrollView?.contentSize = imageView.frame.size
            
            spinner?.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.addSubview(imageView)

        guard let photoTitleText = photoItem?.title else { return }
        self.photoTitle?.text = photoTitleText.capitalizedString
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
    
    // TODO: Add tap gesture and display image in full screen
    
}
