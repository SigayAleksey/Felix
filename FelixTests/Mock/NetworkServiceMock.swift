//
//  NetworkServiceMock.swift
//  FelixTests
//
//  Created by Alexey Sigay on 01.05.2023.
//

import Foundation
@testable import Felix

class NetworkServiceMock: CitiesFetching {
    var returnValue: [City]? = nil
    
    private(set) var fetchCitiesWasCalled = false
    private(set) var fetchCitiesNumberOfCalls = 0
    func fetchCities(name: String) async throws -> [City] {
        fetchCitiesWasCalled = true
        fetchCitiesNumberOfCalls += 1
        
        guard let returnValue = returnValue else {
            throw NetworkError.invalidRequest
        }
        return returnValue
    }
}
