//
//  PlotDataResponse.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 23/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import ObjectMapper



struct PlotDataResponse : Mappable {
    init?(map: Map) {
        
    }
 
    var result : Bool?
    var points : [PlotObject]?
    
    
    mutating func mapping(map: Map) {
        result  <- map["success"]
        points  <- map["data.points"]
    }
    
}

struct PlotObject : Mappable, Codable {
    init?(map: Map) {
        
    }
 
    var index : Double?
    var dateString : String?
    
    
    
    mutating func mapping(map: Map) {
        index       <- map["index"]
        dateString  <- map["date"]
    }
    
}

