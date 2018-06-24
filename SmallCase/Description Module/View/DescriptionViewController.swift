//
//  DescriptionViewController.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 21/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import ReachabilitySwift

protocol CaseDescriptionViewDelegate {
    func refreshData(caseObject: SmallCaseObject? , error : Error?)
    func refreshGraphView(points : [PlotObject]?)
}

class DescriptionViewController: UIViewController {
    
    var viewModel: CaseDescriptionViewModel? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    /// Handles loading of graph
    private var graphDelegate = GraphDelegate()
    private var font: UIFont {
        return UIFont(name: "Avenir Next", size: 15.0)!
    }
    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var caseNameLabel: UILabel!
    @IBOutlet fileprivate weak var caseDescriptionLabel: UILabel!
    @IBOutlet fileprivate weak var caseImageView: CustomImageView! {
        didSet {
            caseImageView.startAnimating()
            caseImageView.downloadImage(url: (viewModel?.imageUrl)!){[weak self] _ in
                if self?.loadingIndicator != nil {
                self?.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    @IBOutlet fileprivate weak var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet fileprivate weak var indexValueLabel: UILabel!
    @IBOutlet fileprivate weak var dailyReturnsLabel: UILabel!
    @IBOutlet fileprivate weak var monthlyReturnsLabel: UILabel!
    @IBOutlet fileprivate weak var yearlyReturnsLabel: UILabel!
    @IBOutlet fileprivate weak var rationaleDescriptionLabel: UILabel!
    @IBOutlet fileprivate weak var graphView: BEMSimpleLineGraphView!{
        didSet {
            graphView.delegate = graphDelegate
            graphView.dataSource = graphDelegate
            graphDelegate.customizeGraphViewOtherProperties(graphView: graphView)
            graphDelegate.customizeGraphWithGeneralProperties(graph: graphView, axisColor: UIColor.white)
        }
    }
    //Mark: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoadingView()
        loadingIndicator.startAnimating()
        viewModel?.loadData()
        ReachabilityManager.shared.addListener(listener: self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        ReachabilityManager.shared.removeListener(listener: self)
    }
}

//MARK: - View Delegate
extension DescriptionViewController : CaseDescriptionViewDelegate {
    
    func refreshGraphView( points : [PlotObject]?) {
        hideLoadingView()
        DispatchQueue.main.async { [weak self] in
            self?.graphDelegate.dataObject = points
            self?.graphView.reloadGraph()
        }
        
    }
    
    func refreshData(caseObject: SmallCaseObject?, error: Error?) {
        hideLoadingView()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if error != nil {
                for subview in strongSelf.contentView.subviews {
                    subview.removeFromSuperview()
                }
                let errorView = ErrorView()
                errorView.frame = strongSelf.view.bounds
                
                strongSelf.contentView.addSubview(errorView)
                strongSelf.contentView.setNeedsLayout()
                
                
            }
            else  {
                
                strongSelf.caseNameLabel.text = "\(caseObject?.name ?? "")"
                strongSelf.caseDescriptionLabel.text = "\(caseObject?.descriptionString ?? "" )"
                strongSelf.indexValueLabel.text = "\(caseObject?.indexValue ?? 0)"
                strongSelf.dailyReturnsLabel.text = "\(caseObject?.dailyReturn ?? 0 )"
                strongSelf.monthlyReturnsLabel.text = "\(caseObject?.monthlyReturn ?? 0 )"
                strongSelf.yearlyReturnsLabel.text = "\(caseObject?.yearlyReturn ?? 0 )"
                
                strongSelf.rationaleDescriptionLabel.attributedText = "\(caseObject?.rationale ?? "")".convertHtml()
                strongSelf.rationaleDescriptionLabel.font = strongSelf.font
            }
        }
        
    }
    
}
//MARK: - Network Listener
extension DescriptionViewController: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.NetworkStatus) {
        switch status {
        case .notReachable:
            showAlert(message: "Network became unreachable")
            debugPrint("ViewController: Network became unreachable")
        case .reachableViaWiFi:
            showAlert(message: "Network reachable through WiFi")
            debugPrint("ViewController: Network reachable through WiFi")
        case .reachableViaWWAN:
            showAlert(message: "Network reachable through Cellular Data")
            debugPrint("ViewController: Network reachable through Cellular Data")
        }
    }
}


