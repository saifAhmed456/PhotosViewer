//
//  PhotoViewerEndpoint.swift
//  PhotosViewer
//
//  Created by saif ahmed on 16/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
import Moya

protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}

enum PhotoViewerEndpoint : TargetType {
    
    case albumsList
    case photosList(albumID : Int)
    case photoData(url : URL)
    
    
}
extension PhotoViewerEndpoint {
    var baseURL: URL {
        
        switch self {
        
        case .photoData(let url) : return url
        default :  guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else {
            fatalError("URL needs to be set")
        }
        return url
        
        }
    }
    var path: String {
        switch self {
        case .albumsList : return "albums"
        case .photosList(let albumID) : return "albums/\(albumID)/photos"
        default : return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .albumsList, .photosList, .photoData :
            return .get
        
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        
        default : return .requestPlain

        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


extension PhotoViewerEndpoint : MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        switch self {
        case .albumsList, .photosList, .photoData : return .returnCacheDataElseLoad
        }
    }
    
    
}
