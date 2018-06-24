//
//  EntryViewModel.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation

protocol EntryViewModel {
    /// Returns the total rows required
    func numberOfRows() -> Int
    
    /// Data Model
    var model : EntryModel? { get set}
    
    // Returns Image Url For a row
    func urlString(forIndex indexPath: IndexPath) -> String
}

class EntryViewModelImplementation : EntryViewModel {
    
    var model: EntryModel?
    
    func numberOfRows() -> Int {
        return model!.imageIds.count
    }

    func urlString(forIndex indexPath: IndexPath) -> String {
        let url = Constants.urls.smallImageUrl + model!.imageIds[indexPath.row] + ".png"
        return url
    }
    
}

