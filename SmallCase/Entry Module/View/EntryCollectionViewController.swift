//
//  EntryCollectionViewController.swift
//  SmallCase
//
//  Created by Shivani Dosajh on 18/06/18.
//  Copyright © 2018 Shivani Dosajh. All rights reserved.
//

import UIKit
import ReachabilitySwift

class EntryCollectionViewController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView : UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: Constants.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCellReuseId)
    
        }
        
    }
    var viewModel : EntryViewModel? {
        didSet {
            viewModel?.model = EntryModel()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        ReachabilityManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ReachabilityManager.shared.removeListener(listener: self)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    // initialization
        viewModel = EntryViewModelImplementation()

    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DescriptionViewController , let row = sender as? Int{
            let scid = viewModel?.model?.imageIds[row] ?? ""
            vc.viewModel = CaseDescriptionViewModelImplementation(scid: scid , model: CaseDescriptionModelImplementation(caseId: scid))
            vc.viewModel?.viewDelegate = vc
        }
    }
    
    
}

extension EntryCollectionViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.numberOfRows() ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellReuseId, for: indexPath)
        if let cell = cell as? EntryCollectionViewCell {
            cell.loadCell(urlString: viewModel?.urlString(forIndex: indexPath) ?? "")
            return cell
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.entryToDescriptionSegueId, sender: indexPath.row)
    }
    
    
}
// MARK: - Flow Layout Delegate
extension EntryCollectionViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension EntryCollectionViewController: NetworkStatusListener {
    
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
