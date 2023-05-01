//
//  City.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import Foundation

struct City: Decodable, Identifiable, Equatable {
    let id: String
    let geonameId: Int
    let type: String
    let name: String
    let population: Int
    let elevation: Int
    let timezoneId: String
    let country: Country
    let adminDivision1: AdminDivision
    let adminDivision2: AdminDivision?
    let score: Double
    let coordinates: Coordinates
    
    struct Country: Decodable, Equatable {
        let id: String
        let geonameId: Int
        let name: String
    }
    
    struct AdminDivision: Decodable, Equatable {
        let id: String
        let geonameId: Int
        let name: String
    }

    struct Coordinates: Decodable, Equatable {
        let latitude: Double
        let longitude: Double
    }
}
