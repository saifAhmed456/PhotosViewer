//
//  PhotosListViewmodel.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import Moya

protocol PhotosListFlowCoordinating {
    func goToPhotoDetails(with url : URL, title : String?)
}
class PhotosListViewModel {
    let flowCoordinator : PhotosListFlowCoordinating
    let albumIDRelay = BehaviorRelay<Int?>(value: nil)
    let photosList = BehaviorRelay<[Photo]?>(value : nil)
    let disposeBag = DisposeBag()
    let networking = Networking.shared
    let animateSpinner = BehaviorRelay<Bool>(value: false)
    let indexPathSelected = PublishSubject<IndexPath>()
    var reload = BehaviorSubject<Void>(value: ())
    var albumTitle : String?
    init(flowCoordinator : PhotosListFlowCoordinating) {
        self.flowCoordinator = flowCoordinator
        setupBindings()
    }
    
    func setupBindings(with view : PhotosListViewControllerProtocol) {
        view.dataSourceRelay.accept(self)
        
        view.indexPathSelected
            .bind(to: indexPathSelected)
            .disposed(by: disposeBag)
        
        animateSpinner
            .bind(to: view.animateSpinner)
            .disposed(by: disposeBag)
        
        Observable.of(albumTitle)
            .bind(to: view.navItemTitle)
            .disposed(by : disposeBag)
        
    }
    func setupBindings() {
        albumIDRelay
            .unwrap()
            .flatMap {[weak self] (albumID) -> Observable<[Photo]?> in
                guard let `self` = self else { return .empty() }
                self.animateSpinner.accept(true)
                let photosListEndpoint = PhotoViewerEndpoint.photosList(albumID: albumID)
                return self.networking.request(endpoint : photosListEndpoint)
                    .asObservable()
                    .do(onDispose : {[weak self] () in
                        self?.animateSpinner.accept(false)
                        
                    })
                    .map([Photo]?.self)
            }
            .bind(to: photosList)
            .disposed(by: disposeBag)
        
        photosList
            .unwrap()
            .map{_ in return }
            .bind(to: reload)
            .disposed(by: disposeBag)
        
        indexPathSelected.withLatestFrom(photosList) { (indexPath, photosList) -> Photo? in
            guard indexPath.row < (photosList?.count ?? 0) else {
                return nil
            }
            return photosList?[indexPath.row]
        }.subscribe(onNext : {[weak self] photo in
            guard let urlString = photo?.photoURL, let url = URL(string: urlString) else { return }
            self?.flowCoordinator.goToPhotoDetails(with: url, title: photo?.title)
            
        }).disposed(by : disposeBag)
        
       
    }
}
