//
//  PlaceDetailsViewModel.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import MapKit

@MainActor
protocol PlaceDetailsViewModelProtocol: ObservableObject {
    /// Status of receiving the data from the network
    var state: FeatureState<PlaceDetails> { get }
    var coordinateRegion: MKCoordinateRegion { get set }
    var details: PlaceDetails? { get set }
    /// Send network request
    func getDetails() async
}

@MainActor
final class PlaceDetailsViewModel: PlaceDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var state: FeatureState<PlaceDetails> = .none
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var details: PlaceDetails?
    
    // MARK: - Private properties
    
    private let networkService: PlaceDetailsFetching
    private let placeID: String

    // MARK: - Init
    
    init(
        networkService: PlaceDetailsFetching,
        placeID: String
    ) {
        self.networkService = networkService
        self.placeID = placeID
    }

    // MARK: - Functions
    
    func getDetails() async {
        do {
            let details = try await networkService.fetchPlaceDetails(id: placeID)
            self.details = details
            coordinateRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: details.coordinates.latitude,
                    longitude: details.coordinates.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            )
            
            state = .success(result: details)
        } catch {
            state = .error(error: .serverError)
        }
    }
}

extension PlaceDetailsViewModel: ErrorViewDelegate {
    var repeatableOptions: ErrorViewRepeatableOptions { .repeatable }
    
    func cancelAction() {
        state = .none
    }
    
    func repeatAction() {
        Task { await getDetails() }
    }
}
