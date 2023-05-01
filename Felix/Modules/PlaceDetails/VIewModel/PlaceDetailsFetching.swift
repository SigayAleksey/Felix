//
//  PlaceDetailsFetching.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import Foundation

protocol PlaceDetailsFetching {
    func fetchPlaceDetails(id: String) async throws -> PlaceDetails
}

extension NetworkService: PlaceDetailsFetching {
    func fetchPlaceDetails(id: String) async throws -> PlaceDetails {
        guard let request = NetworkService.requestFactory.create(PlaceDetailsRequest(placeID: id)) else {
            throw NetworkError.invalidRequest
        }

        return try await NetworkService.shared.fetchData(on: request)
    }
}
