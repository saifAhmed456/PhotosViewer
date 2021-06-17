//
//  PhotoDetailViewController.swift
//  PhotosViewer
//
//  Created by saif ahmed on 18/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
protocol PhotoDetailViewControllerProtocol {
    var imageBinder : Binder<UIImage?> { get }
    var navItemTitle : Binder<String?> { get }
    var animateSpinner : Binder<Bool> { get }
}
class PhotoDetailViewController: UIViewController {
    @IBOutlet var navItem: UINavigationItem!
    
    @IBOutlet var photoDetailView: PhotoDetailView!
    var viewModel : PhotoDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setupBindings(with : self)
        // Do any additional setup after loading the view.
    }
 
}

extension PhotoDetailViewController : PhotoDetailViewControllerProtocol {
    var animateSpinner: Binder<Bool> {
        return photoDetailView.spinner.rx.isAnimating
    }
    
    var imageBinder: Binder<UIImage?> {
        return photoDetailView.imageView.rx.image
    }
    
    var navItemTitle: Binder<String?> {
        return navItem.rx.title
    }
    
    
}
