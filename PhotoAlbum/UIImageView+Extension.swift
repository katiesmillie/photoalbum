//
//  UIImageView+Extension.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/13/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setBorderForImages() {
        self.layer.borderColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.2 ).CGColor
        self.layer.borderWidth = 3
        self.layer.masksToBounds = true
    }

    
}
    



