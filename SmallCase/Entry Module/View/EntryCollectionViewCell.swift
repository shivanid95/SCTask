//
//  EntryCollectionViewCell.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

class EntryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView:CustomImageView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func loadCell(urlString : String){
        
        let url = URL(string: urlString)
        loadingIndicator.startAnimating()
        imageView.downloadImage(url: url!){ _ in
            self.loadingIndicator.stopAnimating()
        }
    }

}

