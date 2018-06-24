//
//  Constants.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

enum Constants {
    
    static let collectionViewCellNibName =  "EntryCollectionViewCell"
    static let collectionViewCellReuseId = "EntryCellId"
    static let entryToDescriptionSegueId = "showDescriptionController"
    
    enum urls {
        static let caseDescripitonUrl = "https://api-dev.smallcase.com/smallcases/smallcase"
        static let smallImageUrl = "https://www.smallcase.com/images/smallcases/130/"
        static let bigImageUrl = "https://www.smallcase.com/images/smallcases/187/"
        static let historicalDataUrl = "https://api-dev.smallcase.com/smallcases/historical"
    }
    
    enum screen {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
}
