//
//  AlbumsListViewModel.swift
//  PhotosViewer
//
//  Created by saif ahmed on 16/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

struct AlbumsListTableViewCellData : AlbumsListTableViewCellDataSourceProtocol {
    var title: String?
    
    init(album : Album) {
        self.title = album.title
    }
}

protocol AlbumsListFlowCoordinating  {
    func goToPhotosList(for albumID : Int)
}
class AlbumsListViewModel {
    
    let networking = Networking()
    let albumsList = BehaviorRelay<[Album]?>(value: nil)
    let reload = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    let indexPathSelected = PublishSubject<IndexPath>()
    let flowCoordinator : AlbumsListFlowCoordinating
    
    init(flowCoordinator : AlbumsListFlowCoordinating) {
        self.flowCoordinator = flowCoordinator
        setupBindings()
        fetchAlbumsList()
    }
    func setupBindings(with view : AlbumsListViewControllerProtocol) {
        view.dataSourceRelay.accept(self)
        
        view.indexPathSelected
            .bind(to: indexPathSelected)
            .disposed(by: disposeBag)
    }
    
    func fetchAlbumsList() {
        let albumsListEndpoint = PhotoViewerEndpoint.albumsList
        networking.request(endpoint: albumsListEndpoint)
            .map([Album].self)
            .debug("", trimOutput: true)
            .asObservable()
            .bind(to: albumsList)
            .disposed(by: disposeBag)
        
    }
    func setupBindings() {
        albumsList
            .unwrap()
            .map{_ in return }
            .bind(to: reload)
            .disposed(by: disposeBag)
    }
    
}

extension AlbumsListViewModel : AlbumsListTableViewDataSourceProtocol {
    var numOfSections: Int {
        return 1
    }
    
    func numOfItems(in section: Int) -> Int {
        return albumsList.value?.count ?? 0
    }
    
    func item(for indexPath: IndexPath) -> AlbumsListTableViewCellDataSourceProtocol? {
        guard  indexPath.row < (albumsList.value?.count ?? 0), let album = albumsList.value?[indexPath.row] else { return nil }
        return AlbumsListTableViewCellData(album: album)
        
    }
    
    
}
