//
//  UIViewController(ext).swift
//  SmallCase
//
//  Created by Shivani Dosajh on 24/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit
import ReachabilitySwift

extension UIViewController {
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Internet Connection", message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissButton)
        self.present(alert, animated: true, completion: nil)
    }

    func showLoadingView() {
        
        let loadingView = UIView()
        loadingView.tag = 1098
        loadingView.frame = CGRect(x: Constants.screen.width/2-40, y: Constants.screen.height/2-80, width: 80, height: 80)
        loadingView.backgroundColor = .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd = UIActivityIndicatorView()
        actInd.tag = 1099
        actInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        actInd.transform = CGAffineTransform(scaleX: 2, y: 2)
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        actInd.startAnimating()
        
        loadingView.addSubview(actInd)
        self.view.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        for subViews in self.view.subviews {
            if subViews.tag == 1098 {
                for subview in subViews.subviews {
                    if subview.tag == 1099 {
                        subview.removeFromSuperview()
                    }
                }
                subViews.removeFromSuperview()
            }
        }
    }

}

