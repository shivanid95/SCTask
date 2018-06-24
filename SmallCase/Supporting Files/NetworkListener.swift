//
//  NetworkListener.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 24/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import ReachabilitySwift

/// Protocol for listenig network status change

public protocol NetworkStatusListener : class {
    
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}
