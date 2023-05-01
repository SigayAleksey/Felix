//
//  CitiesViewModel+Stub.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import MapKit

extension CitiesViewModel {
    struct Stub {
        static var coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7143, longitude: -74.006),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
        
        class Error: CitiesViewModelProtocol, MapZoomButtonsProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<[City]> =
                .error(error: NetworkError.serverError)
            var cities: [City] = []
            @Published var coordinateRegion = Stub.coordinateRegion
            @Published var selectedCity: City? = nil
            @Published var showingCityDetails = false
            
            func getCities(name: String) async { }
            func cityWasSelected(id: String) { }

            var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
            func cancelAction() { }
            func repeatAction() { }
            
            func zoom() { }
            func out() { }
        }
        
        class Empty: CitiesViewModelProtocol, MapZoomButtonsProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<[City]> =
                .success(result: [])
            var cities: [City] = []
            @Published var coordinateRegion = Stub.coordinateRegion
            @Published var selectedCity: City? = nil
            @Published var showingCityDetails = false

            func getCities(name: String) async { }
            func cityWasSelected(id: String) { }

            var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
            func cancelAction() { }
            func repeatAction() { }
            
            func zoom() { }
            func out() { }
        }
        
        class Full: CitiesViewModelProtocol, MapZoomButtonsProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<[City]> =
                .success(result: City.Stub.cities)
            var cities: [City] = City.Stub.cities
            @Published var coordinateRegion = Stub.coordinateRegion
            @Published var selectedCity: City? = nil
            @Published var showingCityDetails = false

            func getCities(name: String) async { }
            func cityWasSelected(id: String) { }

            var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
            func cancelAction() { }
            func repeatAction() { }
            
            func zoom() { }
            func out() { }
        }
        
        class WithCityDetails: CitiesViewModelProtocol, MapZoomButtonsProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<[City]> =
                .success(result: City.Stub.cities)
            var cities: [City] = City.Stub.cities
            @Published var coordinateRegion = Stub.coordinateRegion
            @Published var selectedCity: City? = City.Stub.city1
            @Published var showingCityDetails = true

            func getCities(name: String) async { }
            func cityWasSelected(id: String) { }

            var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
            func cancelAction() { }
            func repeatAction() { }
            
            func zoom() { }
            func out() { }
        }
    }
}
