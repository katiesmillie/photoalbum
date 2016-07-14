//
//  UI.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/14/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import UIKit


extension UICollectionViewFlowLayout {
    
    func setCustomLayoutForCollection(collectionView: UICollectionView) {
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
    
}
