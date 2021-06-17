//
//  PhotoListTableViewCell.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
protocol PhotoListTableViewCellDataSourceProtocol {
    var title : String? { get }
    var imageSingleEvent : Single<UIImage?> { get }
}
class PhotoListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PhotosListTableViewCell"
    static var nibName : String {
        return reuseIdentifier
    }

    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spinner.stopAnimating()
        thumbnailImageView.image = nil
        disposeBag = DisposeBag()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with data : PhotoListTableViewCellDataSourceProtocol) {
        
        titleLabel.text = data.title
        spinner.startAnimating()
        
        data.imageSingleEvent
            .observeOn(MainScheduler.asyncInstance)
            .asObservable()
            .do(onNext : {[weak self] _ in
                self?.spinner.stopAnimating()
                self?.spinner.stopAnimating()
            })
            .unwrap()
            .bind(to: thumbnailImageView.rx.image)
            .disposed(by: disposeBag)
            
    }

}
