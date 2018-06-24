//
//  Connectivity.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 24/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//


import Foundation
import Alamofire
class Connectivity {
    // to check if the internet connectivity is available
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
