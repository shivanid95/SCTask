//
//  ReachabilityManager.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 24/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit
import ReachabilitySwift

class ReachabilityManager: NSObject {
    static  let shared = ReachabilityManager()

    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }

    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    // Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    
    //  Array of delegates which are interested to listen to network status change
    var listeners = [NetworkStatusListener]()
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("Network became unreachable")
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
            
        }
            // Sending message to each of the delegates
            for listener in listeners {
                listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
            }
        
    }
    
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }
    
    // MARK: - Listner Related
    
    // Adds a new listener to the listeners array
    /// - parameter delegate: a new listener
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
    /// Removes a listener from listeners array
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
