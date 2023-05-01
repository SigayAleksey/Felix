//
//  PlaceDetails+Stub.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import Foundation

extension PlaceDetails {
    struct Stub {
        static let value = PlaceDetails(
            id: "US",
            geonameId: 6252001,
            type: "COUNTRY",
            name: "United States of America",
            population: 310232863,
            elevation: 543,
            iso2: "US",
            iso3: "USA",
            isoNumeric: "840",
            continentId: "NA",
            domain: ".us",
            currencyCode: "USD",
            currencyName: "Dollar",
            coordinates: PlaceDetails.Coordinates(
                longitude: 39.76,
                latitude: -98.5
            )
        )
    }
}
