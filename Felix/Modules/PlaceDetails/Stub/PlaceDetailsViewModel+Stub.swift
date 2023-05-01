//
//  PlaceDetailsViewModel+Stub.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import MapKit

extension PlaceDetailsViewModel {
    struct Stub {
        class Error: PlaceDetailsViewModelProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<PlaceDetails> =
                .error(error: NetworkError.serverError)
            @Published var coordinateRegion = MKCoordinateRegion()
            @Published var details: PlaceDetails?
            
            func getDetails() async { }
            
            var repeatableOptions: ErrorViewRepeatableOptions = .repeatable
            func cancelAction() { }
            func repeatAction() { }
        }
        
        class Full: PlaceDetailsViewModelProtocol, ErrorViewDelegate {
            @Published private(set) var state: FeatureState<PlaceDetails> =
                .success(result: PlaceDetails.Stub.value)
            @Published var coordinateRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: PlaceDetails.Stub.value.coordinates.latitude,
                    longitude: PlaceDetails.Stub.value.coordinates.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            )
            @Published var details: PlaceDetails? = PlaceDetails.Stub.value
            
            func getDetails() async { }
            
            var repeatableOptions: ErrorViewRepeatableOptions = .repeatable
            func cancelAction() { }
            func repeatAction() { }
        }
    }
}
