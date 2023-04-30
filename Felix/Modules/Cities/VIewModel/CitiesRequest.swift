//
//  CitiesRequest.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import Foundation

struct CitiesRequest: NetworkRequest {
    init(text: String) {
        parameters?["q"] = text
    }
    
    var path = "/places"
    var parameters: URLParameters? = [
        "type": "CITY",
        "skip": 0,
        "country": "US,CA",
        "limit": 10
    ]
}
