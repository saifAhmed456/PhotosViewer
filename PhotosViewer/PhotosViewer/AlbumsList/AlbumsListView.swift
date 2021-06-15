//
//  AlbumsListView.swift
//  PhotosViewer
//
//  Created by saif ahmed on 15/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit

protocol AlbumsListTableViewDataSourceProtocol {
    var numOfSections : Int { get }
    func numOfItems(in section : Int) -> Int
    func item(for indexPath : IndexPath) -> AlbumsListTableViewCellDataSourceProtocol?
    var reload : PublishSubject<Void> { get }
}
class AlbumsListView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
