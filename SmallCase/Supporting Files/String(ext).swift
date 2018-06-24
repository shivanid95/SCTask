//
//  String(ext).swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

extension String{
    
    /// Renders and returns Html as Attributed String
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch{
            return NSAttributedString()
        }
    }
}


