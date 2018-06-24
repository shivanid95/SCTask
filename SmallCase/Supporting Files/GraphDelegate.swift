//
//  GraphDelegate.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 23/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//


import UIKit

import BEMSimpleLineGraph

class GraphDelegate: NSObject , BEMSimpleLineGraphDataSource
{
    // the data to be plotted on the graph
    public var dataObject:[PlotObject]? = []
 
   
    func numberOfPoints(inLineGraph graph: BEMSimpleLineGraphView) -> Int {
              return dataObject?.count ?? 0
        
    }
    
    func lineGraph(_ graph: BEMSimpleLineGraphView, valueForPointAt index: Int) -> CGFloat {
        if let data = dataObject?[index].index  {
            return CGFloat(data)
        }
        return CGFloat(0)
        
    }
    
    func lineGraph(_ graph: BEMSimpleLineGraphView, labelOnXAxisFor index: Int) -> String {
        if let date = dataObject?[index].dateString {
            return date }
        else {
            return "Date"
        }
        
    }
    
}

extension GraphDelegate : BEMSimpleLineGraphDelegate {
    func customizeGraphWithGeneralProperties(graph : BEMSimpleLineGraphView , axisColor: UIColor ) {
        graph.clipsToBounds = true
        graph.enableXAxisLabel = true
        graph.enableYAxisLabel = true
        graph.enableBezierCurve = true
        graph.widthLine = 1.5
        graph.colorYaxisLabel = axisColor
        graph.colorXaxisLabel = axisColor
    }
    
    func customizeGraphViewOtherProperties(graphView : BEMSimpleLineGraphView )
    {
        
        
        graphView.alphaLine = 1.0
        graphView.colorBottom = UIColor.black
        graphView.colorTop = UIColor.black
        
        graphView.backgroundColor = UIColor.clear
        
        graphView.colorBackgroundXaxis = UIColor.black
        graphView.colorBackgroundYaxis = UIColor.black
        graphView.colorLine = UIColor.green
        
        graphView.enableReferenceAxisFrame = true
        graphView.enableTopReferenceAxisFrameLine = true
        graphView.enableLeftReferenceAxisFrameLine = true
        graphView.enableRightReferenceAxisFrameLine = true
        graphView.enableBottomReferenceAxisFrameLine = true
        graphView.alwaysDisplayDots = true
        
    }
    
}


