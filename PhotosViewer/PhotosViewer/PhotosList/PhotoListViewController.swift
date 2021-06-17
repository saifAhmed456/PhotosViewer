//
//  PhotoListViewController.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
protocol PhotosListViewControllerProtocol : BaseListViewControllerProtocol {
    var dataSourceRelay : BehaviorRelay<PhotosListTableViewDataSourceProtocol?> { get }
    var navItemTitle : Binder<String?> { get }
}
class PhotoListViewController: UIViewController {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var photosListView: PhotosListView!
    var viewModel : PhotosListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setupBindings(with: self)

        // Do any additional setup after loading the view.
    }
    


}

extension PhotoListViewController : PhotosListViewControllerProtocol {
    var navItemTitle: Binder<String?> {
        return navItem.rx.title
    }
    
    var dataSourceRelay: BehaviorRelay<PhotosListTableViewDataSourceProtocol?> {
        return photosListView.dataSourceRelay
    }
    
    var indexPathSelected: Observable<IndexPath> {
        return photosListView.indexPathSelected
    }
    
    var animateSpinner: PublishSubject<Bool> {
        return photosListView.animateSpinner
    }
    
    
}
