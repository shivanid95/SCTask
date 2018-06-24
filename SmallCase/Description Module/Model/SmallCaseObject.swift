//
//  SmallCaseObject.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import ObjectMapper



struct SmallCaseObject : Mappable, Codable{
    
    var name : String?
    var descriptionString : String?
    var rationale : String?
    var indexValue : Double?
    var dailyReturn : Double?
    var monthlyReturn : Double?
    var yearlyReturn : Double?
    
    var scid : String?
    var plotData : [PlotObject]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name                 <- map["data.info.name"]
        descriptionString    <- map["data.info.shortDescription"]
        rationale            <- map["data.rationale"]
        indexValue           <- map["data.stats.indexValue"]
        dailyReturn          <- map["data.stats.returns.daily"]
        monthlyReturn        <- map["data.stats.returns.monthly"]
        yearlyReturn         <- map["data.stats.returns.yearly"]
        scid                 <- map["data.scid"]
        
        
    }
    
}

extension SmallCaseObject {
  /// Archiving the fetched smallCase Data
    func save() {
        Storage.store(self, to: .caches, as: "\(self.scid ?? "temp")")
    }
}


