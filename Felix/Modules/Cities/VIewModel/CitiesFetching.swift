//
//  CitiesFetching.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import Foundation

protocol CitiesFetching {
    func fetchCities(name: String) async throws -> [City]
}

extension NetworkService: CitiesFetching {
    func fetchCities(name: String) async throws -> [City] {
        guard let request = NetworkService.requestFactory.create(CitiesRequest(text: name)) else {
            throw NetworkError.invalidRequest
        }

        return try await NetworkService.shared.fetchData(on: request)
    }
}
