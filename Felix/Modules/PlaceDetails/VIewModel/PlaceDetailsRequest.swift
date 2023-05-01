//
//  PlaceDetailsRequest.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import Foundation

struct PlaceDetailsRequest: NetworkRequest {
    init(placeID: String) {
        path.append(placeID)
    }
    
    var path = "/places/"
    var parameters: URLParameters? = nil
}
