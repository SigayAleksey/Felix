//
//  CitiesMapView.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import SwiftUI
import MapKit

struct CitiesMapView<ViewModel: CitiesViewModelProtocol & MapZoomButtonsProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $viewModel.coordinateRegion,
                showsUserLocation: false,
                annotationItems: viewModel.cities
            ) { city in
                MapAnnotation(
                    coordinate: CLLocationCoordinate2D(
                        latitude: city.coordinates.latitude,
                        longitude: city.coordinates.longitude
                    )
                ) {
                    MapAnnotationImage()
                        .onTapGesture {
                            viewModel.cityWasSelected(id: city.id)
                        }
                }
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: viewModel.coordinateRegion)
            
            MapZoomButtons(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.showingCityDetails) {
            NavigationView {
                if let city = viewModel.selectedCity {
                    CityDetailsView(city: city)
                }
            }
        }
    }
}

struct CitiesMapView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesMapView(
            viewModel: CitiesViewModel.Stub.Full()
        )
        .previewDisplayName("Full")

        CitiesMapView(
            viewModel: CitiesViewModel.Stub.WithCityDetails()
        )
        .previewDisplayName("WithCityDetails")
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta &&
        lhs.center.latitude == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude
    }
}
