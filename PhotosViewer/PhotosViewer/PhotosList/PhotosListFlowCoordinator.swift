//
//  PhotosListFlowCoordinator.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import UIKit
class PhotosListFlowCoordinator : PhotosListFlowCoordinating{
   
    weak var navigator : UINavigationController?
    weak var presenter : UIViewController?
    
    static func prepareView(for albumID : Int ,albumTitle : String?, with navigator : UINavigationController?) -> UIViewController {
        let storyboard = UIStoryboard(name: "PhotosListStoryboard", bundle: nil)
        guard let vc =  storyboard.instantiateInitialViewController() as? PhotoListViewController else {
            fatalError("Can not instantiate photos list view controller")
        }
        let flowCoordinator = PhotosListFlowCoordinator()
        flowCoordinator.presenter = vc
        flowCoordinator.navigator = navigator
        let viewmodel = PhotosListViewModel(flowCoordinator: flowCoordinator)
        viewmodel.albumIDRelay.accept(albumID)
        viewmodel.albumTitle = albumTitle
        vc.viewModel = viewmodel
        
        return vc
    }
    
    func goToPhotoDetails(with url: URL, title: String?) {
        let vc = PhotoDetailFlowCoordinator.prepareView(with: url, photoTitle: title, navigator: navigator)
        navigator?.pushViewController(vc, animated: true)
    }
    
}
