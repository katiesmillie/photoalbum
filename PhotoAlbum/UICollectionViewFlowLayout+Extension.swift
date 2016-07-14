//
//  UI.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/14/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit


extension UICollectionViewFlowLayout {
    
    func setLayoutForAlbums() {
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right:10)
        minimumInteritemSpacing = 0
    }
    
}
