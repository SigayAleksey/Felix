//
//  City+Stub.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import Foundation

extension City {
    struct Stub {
        static let city1 = City(
            id: "5128581",
            geonameId: 5128581,
            type: "CITY",
            name: "New York",
            population: 8804190,
            elevation: 10,
            timezoneId: "America/New_York",
            country: City.Country(
                id: "US",
                geonameId: 6252001,
                name: "United States of America"
            ),
            adminDivision1: City.AdminDivision(
                id: "US.NY",
                geonameId: 5128638,
                name: "New York"
            ),
            adminDivision2: nil,
            score: 241.2053,
            coordinates: City.Coordinates(
                latitude: 40.7143,
                longitude: -74.006
            )
        )
        
        static let city2 = City(
            id: "5140405",
            geonameId: 5140405,
            type: "CITY",
            name: "Syracuse",
            population: 144142,
            elevation: 121,
            timezoneId: "America/New_York",
            country: City.Country(
                id: "US",
                geonameId: 6252001,
                name: "United States of America"
            ),
            adminDivision1: City.AdminDivision(
                id: "US.NY",
                geonameId: 5128638,
                name: "New York"
            ),
            adminDivision2: City.AdminDivision(
                id: "US.NY.067",
                geonameId: 5129867,
                name: "Onondaga"
            ),
            score: 177.63646,
            coordinates: City.Coordinates(
                latitude: 43.0481,
                longitude: -76.1474
            )
        )
        
        static let city3 = City(
            id: "5106834",
            geonameId: 5106834,
            type: "CITY",
            name: "Albany",
            population: 98469,
            elevation: 45,
            timezoneId: "America/New_York",
            country: City.Country(
                id: "US",
                geonameId: 6252001,
                name: "United States of America"
            ),
            adminDivision1: City.AdminDivision(
                id: "US.NY",
                geonameId: 5128638,
                name: "New York"
            ),
            adminDivision2: City.AdminDivision(
                id: "US.NY.001",
                geonameId: 5106841,
                name: "Albany"
            ),
            score: 176.86394,
            coordinates: City.Coordinates(
                latitude: 42.6526,
                longitude: -73.7562
            )
        )
        
        static let cities = [city1, city2, city3]
    }
}
