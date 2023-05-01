//
//  PlaceDetails.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import Foundation

struct PlaceDetails: Decodable, Identifiable, Equatable {
    let id: String
    let geonameId: Int
    let type: String
    let name: String
    let population: Int
    let elevation: Int
    let iso2: String
    let iso3: String
    let isoNumeric: String
    let continentId: String
    let domain: String
    let currencyCode: String
    let currencyName: String
    let coordinates: Coordinates
    
    struct Coordinates: Decodable, Equatable {
        let longitude: Double
        let latitude: Double
    }
}
