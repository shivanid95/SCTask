//
//  CaseDescriptionVIewModel.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import Foundation

/// View ModelApi
protocol CaseDescriptionViewModel {
    var model : CaseDescriptionModel? { get set}
    /// Small Case Id
    var scid : String? { get set}
    /// Url For fetching large image
    var imageUrl: URL? {get}
    /// required initializer
    init(scid : String, model: CaseDescriptionModel)
    /// Delegate to communicate with the view
    var viewDelegate: CaseDescriptionViewDelegate? { get set}
    
    /// Fetches the small Case Data
    func loadData()
    
}


class CaseDescriptionViewModelImplementation : CaseDescriptionViewModel {
    
    var viewDelegate: CaseDescriptionViewDelegate?
    var model: CaseDescriptionModel?
    var scid: String?
    
    required init(scid: String, model : CaseDescriptionModel) {
        self.scid = scid
        self.model = model
    }
    
    private var smallCaseData : SmallCaseObject? {
        didSet {
            viewDelegate?.refreshData(caseObject: smallCaseData, error: nil)
        }
    }
    
    private var graphData : [PlotObject]? {
        get {
            return smallCaseData?.plotData
        }
        set {
            smallCaseData?.plotData = newValue
            viewDelegate?.refreshGraphView(points: smallCaseData?.plotData)
        }
    }
    
    var imageUrl: URL? {
        let urlString = Constants.urls.bigImageUrl + scid! + ".png"
        return URL(string: urlString)
    }
    
    func loadData() {
        if Storage.fileExists(scid!, in: .caches) {
            smallCaseData = Storage.retrieve(scid!, from: .caches, as: SmallCaseObject.self)
            graphData = smallCaseData?.plotData
            return
        }
        else if smallCaseData == nil {
            
            model?.smallCase { [weak self] (caseObject,error) in
                guard error == nil else {
                    self?.viewDelegate?.refreshData(caseObject: nil, error: error)
                    return
                }
                if let obj = caseObject {
                    self?.smallCaseData = obj
                }
            }
            loadGraphPoints()
        }
        
    }
    
    func loadGraphPoints() {
        guard graphData == nil else {
            return
        }
        model?.historicalCaseData{[weak self] (plotPoints, error)  in
            if self?.smallCaseData != nil  {
                self?.graphData = plotPoints
                DispatchQueue.main.async {
                    self?.smallCaseData?.save()
                }
            }
        }
    }

}


