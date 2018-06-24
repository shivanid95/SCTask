//
//  ImageView(ext).swift
//  SmallCase
//
//  Created by Shivani Dosajh on 23/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView : UIImageView {
    
    var lastLoadedImageUrlString : String?
  /// Asynchronously downloads an image and sets the Image View
 /// - Paramters
    ///     - url: Image Url from which the image is to be fetched
    ///     - completion : returns the status of the download Completion
    func downloadImage(url: URL, completion : @escaping(Bool)-> Void) {
        
        lastLoadedImageUrlString = url.absoluteString
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion(true)
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data,response , error) in
                if let imageData = data , let newImage = UIImage(data : imageData) {
                    DispatchQueue.main.async { [weak self] in
                        if self?.lastLoadedImageUrlString == url.absoluteString {
                            self?.image = newImage
                            
                        }
                        imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                        completion(true)
                    }
                }
            }).resume()
        }
        
    }
    
}
