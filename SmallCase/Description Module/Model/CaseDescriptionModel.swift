//
//  CaseDescriptionModel.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

/// Data Model Api
protocol CaseDescriptionModel {
    /// fetches single smallCase data
    func smallCase(completionHandler : @escaping(SmallCaseObject?, Error?) -> Void )
    
    /// fetches the historical case data for graph
    func historicalCaseData(completionHandler : @escaping([PlotObject]?, Error?) -> Void)
}


class CaseDescriptionModelImplementation : CaseDescriptionModel {
    
    var caseId: String
    
    init(caseId : String) {
        self.caseId = caseId
    }
    
    func smallCase(completionHandler : @escaping(SmallCaseObject?, Error?) -> Void ) {
        
        let url = "\(Constants.urls.caseDescripitonUrl)?scid=\(caseId)"
        print(url)
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseObject { (response : DataResponse<SmallCaseObject>) in
            switch response.result {
            case .success(let value) :
                print(value)
                completionHandler(value ,nil)
            case .failure(let error) :
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func historicalCaseData(completionHandler : @escaping([PlotObject]?, Error?) -> Void) {
        let urlString = Constants.urls.historicalDataUrl
        let params = ["scid" : caseId]
        
        Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: nil).validate().responseObject { (response : DataResponse<PlotDataResponse>) in
            switch response.result {
            case .success(let value) :
                print(value)
                completionHandler(value.points ,nil)
            case .failure(let error) :
                print(error)
                completionHandler(nil, error)
            }
        }
        
    }
    
}
