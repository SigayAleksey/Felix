//
//  CitiesViewModel.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import MapKit

@MainActor
protocol CitiesViewModelProtocol: ObservableObject {
    /// Status of receiving the data from the network
    var state: FeatureState<[City]> { get }
    
    var cities: [City] { get }
    var coordinateRegion: MKCoordinateRegion { get set }
    var selectedCity: City? { get set }
    var showingCityDetails: Bool { get set }
    
    /// Send network request
    func getCities(name: String) async
    func cityWasSelected(id: String)
}

@MainActor
final class CitiesViewModel: CitiesViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var state: FeatureState<[City]> = .none
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var selectedCity: City?
    @Published var showingCityDetails = false
    
    var cities: [City] {
        switch state {
        case .success(let cities):
            return cities
        default:
            return []
        }
    }
    
    private var refreshTimer: Timer?
    
    // MARK: - Private properties
    
    private let networkService: CitiesFetching
    
    // MARK: - Init
    
    init(networkService: CitiesFetching) {
        self.networkService = networkService
    }

    // MARK: - Functions
    
    func getCities(name: String) async {
        do {
            let cities = try await networkService.fetchCities(name: name)
            
            if let region = calculateCoordinateRegion(for: cities) {
                coordinateRegion = region
            }
            state = .success(result: cities)
        } catch {
            state = .error(error: .serverError)
        }
    }
    
    func cityWasSelected(id: String) {
        guard let city = cities.first(where: { $0.id == id }) else { return }
        selectedCity = city
        showingCityDetails = true
    }
    
    // MARK: - Private functions
    
    private func calculateCoordinateRegion(for cities: [City]) -> MKCoordinateRegion? {
        guard let firstCity = cities.first else { return nil }

        guard cities.count > 2 else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: firstCity.coordinates.latitude,
                    longitude: firstCity.coordinates.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
        
        var maxLatitude: Double = firstCity.coordinates.latitude
        var minLatitude: Double = firstCity.coordinates.latitude
        var maxLongitude: Double = firstCity.coordinates.longitude
        var minLongitude: Double = firstCity.coordinates.longitude
        
        for city in cities {
            if city.coordinates.latitude > maxLatitude {
                maxLatitude = city.coordinates.latitude
            }
            if city.coordinates.latitude < minLatitude {
                minLatitude = city.coordinates.latitude
            }
            if city.coordinates.longitude > maxLongitude {
                maxLongitude = city.coordinates.longitude
            }
            if city.coordinates.longitude < minLongitude {
                minLongitude = city.coordinates.longitude
            }
        }
        
        let centerLatitude = (maxLatitude - minLatitude) / 2 + minLatitude
        let centerLongitude = (maxLongitude - minLongitude) / 2 + minLongitude
        let center = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
        
        let span = MKCoordinateSpan(
            latitudeDelta: maxLatitude - centerLatitude + 0.1,
            longitudeDelta: maxLongitude - centerLongitude + 0.1
        )
        
        return MKCoordinateRegion(center: center, span: span)
    }
}

extension CitiesViewModel: ErrorViewDelegate {
    var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
    
    func cancelAction() {
        state = .none
    }
    
    func repeatAction() { }
}

extension CitiesViewModel: MapZoomButtonsProtocol {
    func zoom() {
        let latitudeDelta = coordinateRegion.span.latitudeDelta
        let longitudeDelta = coordinateRegion.span.longitudeDelta
        if coordinateRegion.span.latitudeDelta > 0.01,
           coordinateRegion.span.longitudeDelta > 0.01 {
            DispatchQueue.main.async {
                self.coordinateRegion = MKCoordinateRegion(
                    center: self.coordinateRegion.center,
                    span: MKCoordinateSpan(
                        latitudeDelta: self.coordinateRegion.span.latitudeDelta - latitudeDelta*0.3,
                        longitudeDelta: self.coordinateRegion.span.longitudeDelta - longitudeDelta*0.3
                    )
                )
            }
        }
    }
    
    func out() {
        let latitudeDelta = coordinateRegion.span.latitudeDelta
        let longitudeDelta = coordinateRegion.span.longitudeDelta
        if coordinateRegion.span.latitudeDelta < 20,
           coordinateRegion.span.longitudeDelta < 20 {
            DispatchQueue.main.async {
                self.coordinateRegion = MKCoordinateRegion(
                    center: self.coordinateRegion.center,
                    span: MKCoordinateSpan(
                        latitudeDelta: self.coordinateRegion.span.latitudeDelta + latitudeDelta*0.3,
                        longitudeDelta: self.coordinateRegion.span.longitudeDelta + longitudeDelta*0.3
                    )
                )
            }
        }
    }
}
