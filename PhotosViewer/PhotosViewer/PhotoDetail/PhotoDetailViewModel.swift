//
//  PhotoDetailViewModel.swift
//  PhotosViewer
//
//  Created by saif ahmed on 18/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

protocol PhotoDetailFlowCoordinating {
    
}
class PhotoDetailViewModel {
    let flowCoordinator : PhotoDetailFlowCoordinating
    let photoURLSubject = PublishSubject<URL>()
    let networking = Networking.shared
    let disposeBag = DisposeBag()
    var photoTitle : String?
    let imageRelay = BehaviorRelay<UIImage?>(value : nil)
    let animateSpinner = BehaviorRelay<Bool>(value: false)
    init(flowCoordinator : PhotoDetailFlowCoordinating) {
        self.flowCoordinator = flowCoordinator
        setupBindings()
    }
    func setupBindings(with view : PhotoDetailViewControllerProtocol) {
        imageRelay
            .bind(to: view.imageBinder)
            .disposed(by: disposeBag)
        
        Observable.of(photoTitle)
            .bind(to: view.navItemTitle)
            .disposed(by: disposeBag)
        
        animateSpinner
            .bind(to: view.animateSpinner)
            .disposed(by : disposeBag)
    }
    func setupBindings() {
        photoURLSubject
            .flatMap {[weak self] (url) -> Observable<UIImage?> in
                guard let `self` = self else { return .empty()}
                self.animateSpinner.accept(true)
                let endpoint = PhotoViewerEndpoint.photoData(url: url)
                return self.networking.request(endpoint: endpoint)
                    .asObservable()
                    .do(onDispose : {[weak self] () in
                        self?.animateSpinner.accept(false)
                        
                    })
                    .map{UIImage(data :$0.data)}
                
            }
            .bind(to: imageRelay)
            .disposed(by: disposeBag)
    }
}
