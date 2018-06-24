//
//  ErrorView.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 24/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // initializer delegation
        self.commonInit()
    }
    
    /// setting up view from xib
    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }
    
}

