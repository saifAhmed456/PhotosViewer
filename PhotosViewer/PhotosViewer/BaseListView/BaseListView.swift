//
//  BaseListView.swift
//  PhotosViewer
//
//  Created by saif ahmed on 17/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
protocol BaseListViewControllerProtocol {
    var indexPathSelected : Observable<IndexPath> { get }
    var animateSpinner : PublishSubject<Bool> { get }
}
protocol BaseListTableViewDataSourceProtocol {
    var numOfSections : Int { get }
    func numOfItems(in section : Int) -> Int
    func item(for indexPath : IndexPath)
    var reload : BehaviorSubject<Void> { get }
}
extension BaseListTableViewDataSourceProtocol {
    func item(for indexPath : IndexPath) {
        fatalError("This is an abstract method.")
    }
}

class BaseListView: UIView {
    static let nibName = "BaseListView"
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var tableView: UITableView!
    
    var indexPathSelected : Observable<IndexPath> {
        return tableView.rx.itemSelected.asObservable()
    }
    var animateSpinner = PublishSubject<Bool>()
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
        addXib(withName: BaseListView.nibName)
        tableView.delegate = self
        setupBindings()
    }
    func setupBindings() {
        animateSpinner
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: disposeBag)
    }

}
extension BaseListView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
