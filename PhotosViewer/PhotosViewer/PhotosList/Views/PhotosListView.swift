//
//  PhotosListView.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

protocol PhotosListTableViewDataSourceProtocol : BaseListTableViewDataSourceProtocol {
    
    func item(for indexPath : IndexPath) -> PhotoListTableViewCellDataSourceProtocol?
   
}
class PhotosListView: BaseListView {
    
    var dataSourceRelay = BehaviorRelay<PhotosListTableViewDataSourceProtocol?>(value : nil)
    override func commonInit() {
        super.commonInit()
        setupTableView()
    }

    func setupTableView() {
        tableView.register(UINib(nibName: PhotoListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        
        tableView.dataSource = self
    }
    override func setupBindings() {
     super.setupBindings()
         dataSourceRelay
             .unwrap()
             .flatMap{$0.reload}
             .bind(to: tableView.rx.reload)
             .disposed(by: disposeBag)
     }

}


extension PhotosListView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceRelay.value?.numOfSections ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceRelay.value?.numOfItems(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataSourceRelay.value?.item(for: indexPath), let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier, for: indexPath) as? PhotoListTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with : data)
        return cell
    }
    
    
}
