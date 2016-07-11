//
//  PhotoJSON.swift
//  PhotoAlbum
//
//  Created by Katie Smillie on 7/9/16.
//  Copyright © 2016 Katie Smillie. All rights reserved.
//

import Foundation
import UIKit


public struct PhotoManager {
    
    static func decodeItems(items: [[String: AnyObject]]?) -> [PhotoItem] {
        var photoItems: [PhotoItem] = []
        guard let items = items else { return photoItems }
        
        for item in items {
            guard let albumId = item["albumId"] as? Int else { continue }
            guard let id = item["id"] as? Int else { continue }
            guard let title = item["title"] as? String else { continue }
            guard let thumbnailURL = item["thumbnailUrl"] as? String else { continue }
            guard let imageURL = item["url"] as? String else { continue }
            
            let photoItem = PhotoItem(albumId: albumId, id: id, title: title, thumbnailURL: thumbnailURL, imageURL: imageURL)
            photoItems += [photoItem]
        }
        
        return photoItems
    }
    
    
    static func fetchItems(completion: ([PhotoItem])->()) {
        guard let url = NSURL(string: "http://jsonplaceholder.typicode.com/photos") else { return }
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            let statusCode: Int
            if let response = response as? NSHTTPURLResponse {
                statusCode = response.statusCode
            }
            else {
                statusCode = 0
            }
            
            if statusCode == 200 {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    if let items = json as? [[String: AnyObject]] {
                        let decodedItems = PhotoManager.decodeItems(items)
                        completion(decodedItems)
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        }
        task.resume()
    }
    
    
    static func fetchImage(urlString: String, completion: (Image)->()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            guard let url = NSURL(string: urlString) else { return }
            guard let imageData = NSData(contentsOfURL: url) else { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                let image = Image(status: .Downloaded, image: UIImage(data: imageData))
                completion(image)
            }
        }
    }

}