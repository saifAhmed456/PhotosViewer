//
//  PhotosListResponse.swift
//  PhotosViewer
//
//  Created by saif ahmed on 16/06/21.
//  Copyright © 2021 Saif. All rights reserved.
//

import Foundation
struct Photo : Decodable {
    var title : String?
    var photoURL : String?
    var thumbnailURL : String?
    
    enum CodingKeys :String, CodingKey {
        case title
        case photoURL = "url"
        case thumbnailURL = "thumbnailUrl"
        
    }
}
