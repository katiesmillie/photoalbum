//
//  LoadingViewController.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner?.startAnimating()
    }

}
