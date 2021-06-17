//
//  AlbumsListFlowCoordinator.swift
//  PhotosViewer
//
//  Created by saif ahmed on 16/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import UIKit
class AlbumsListFlowCoordinator : AlbumsListFlowCoordinating {
    var presenter : UIViewController?
    var navigator : UINavigationController?
    
   static  func prepareAlbumsViewController(with navigator : UINavigationController?) -> UIViewController {
        let storyBoard = UIStoryboard(name: "AlbumsListStoryboard", bundle: nil)
    guard   let albumsViewController = storyBoard.instantiateInitialViewController() as? AlbumsListViewController else {
        fatalError("Can not load albums list view controller")
    }
    let flowCoordinator = AlbumsListFlowCoordinator()
    let viewModel = AlbumsListViewModel(flowCoordinator : flowCoordinator)
    albumsViewController.viewModel = viewModel
    flowCoordinator.presenter = albumsViewController
    flowCoordinator.navigator = navigator
    return albumsViewController
    }
    
    func goToPhotosList(for albumID : Int,albumtitle : String?) {
        let photosListVC = PhotosListFlowCoordinator.prepareView(for: albumID, albumTitle: albumtitle, with: navigator)
        navigator?.pushViewController(photosListVC, animated: true)
    }
}
