//
//  AlbumsListTableViewCell.swift
//  PhotosViewer
//
//  Created by saif ahmed on 15/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
protocol AlbumsListTableViewCellViewConfigProtocol {
    var titleLabelFont : UIFont? { get }
    var titleLabelColor : UIColor? { get }
    
}
protocol AlbumsListTableViewCellDataSourceProtocol {
    var title : String? { get }
}
class AlbumsListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AlbumsListTableViewCell"
    static var nibName : String {
        return reuseIdentifier
    }
    @IBOutlet var titleLabel: UILabel!
    var viewConfig : AlbumsListTableViewCellViewConfigProtocol? {
        didSet {
            titleLabel.font = viewConfig?.titleLabelFont
            titleLabel.textColor = viewConfig?.titleLabelColor
        }
    }
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
