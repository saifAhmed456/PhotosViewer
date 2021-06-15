//
//  AlbumsListView.swift
//  PhotosViewer
//
//  Created by saif ahmed on 15/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

protocol AlbumsListTableViewDataSourceProtocol {
    var numOfSections : Int { get }
    func numOfItems(in section : Int) -> Int
    func item(for indexPath : IndexPath) -> AlbumsListTableViewCellDataSourceProtocol?
    var reload : PublishSubject<Void> { get }
}
class AlbumsListView: UIView {

    @IBOutlet var tableView: UITableView!
    let dataSourceRelay = BehaviorRelay<AlbumsListTableViewDataSourceProtocol?>(value: nil)
    let cellConfig = BehaviorRelay<AlbumsListTableViewCellViewConfigProtocol?>(value : nil)
    let disposeBag = DisposeBag()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func  commonInit() {
        addXib()
        setupBindings()
    }
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: AlbumsListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AlbumsListTableViewCell.reuseIdentifier)
    }
    func setupBindings() {
        dataSourceRelay
            .unwrap()
            .flatMap{$0.reload}
            .bind(to: tableView.rx.reload)
            .disposed(by: disposeBag)
    }

}

extension AlbumsListView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceRelay.value?.numOfSections ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceRelay.value?.numOfItems(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: AlbumsListTableViewCell.reuseIdentifier, for: indexPath)
        guard let data = dataSourceRelay.value?.item(for: indexPath), let albumsListCell = tableViewCell as? AlbumsListTableViewCell else {
            return UITableViewCell()
        }
        albumsListCell.viewConfig = cellConfig.value
        albumsListCell.updateCell(with: data)
        return albumsListCell
    }
    
    
}
