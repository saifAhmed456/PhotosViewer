//
//  AlbumsListTableViewCell.swift
//  PhotosViewer
//
//  Created by saif ahmed on 15/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit

protocol AlbumsListTableViewCellDataSourceProtocol {
    var title : String? { get }
}
class AlbumsListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCell(with data : AlbumsListTableViewCellDataSourceProtocol) {
        titleLabel.text = data.title
    }

}
