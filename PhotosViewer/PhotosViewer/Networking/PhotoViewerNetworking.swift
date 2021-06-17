//
//  PhotoViewerNetworking.swift
//  PhotosViewer
//
//  Created by saif ahmed on 16/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

let MEMORY_CAPACITY = 4 * 1024 * 1024
let DISK_CAPACITY =  20 * 1024 * 1024

class Networking {
    
    let cache = Foundation.URLCache(memoryCapacity: MEMORY_CAPACITY, diskCapacity: DISK_CAPACITY, diskPath: nil)
    
    static let shared = Networking()
    
    private init() {
        URLCache.shared = cache
    }
    
    private var provider = MoyaProvider<PhotoViewerEndpoint>(plugins : [MoyaCacheablePlugin()])
    
    func request(endpoint : PhotoViewerEndpoint) -> Single<Response> {
        return provider.rx.request(endpoint)
    }
    
    
}
