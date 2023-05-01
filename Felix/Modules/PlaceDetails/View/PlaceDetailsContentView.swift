//
//  PlaceDetailsContentView.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import SwiftUI
import MapKit

struct PlaceDetailsContentView<ViewModel: PlaceDetailsViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        switch viewModel.state {
        case .success(let placeDetails):
            Group {
                VStack(spacing: 30) {
                    Text(placeDetails.name)
                    
                    Map(
                        coordinateRegion: $viewModel.coordinateRegion,
                        showsUserLocation: false,
                        annotationItems: [placeDetails]
                    ) { place in
                        MapMarker(
                            coordinate: CLLocationCoordinate2D(
                                latitude: place.coordinates.latitude,
                                longitude: place.coordinates.longitude
                            )
                        )
                    }
                    .frame(width: 350, height: 150, alignment: .center)
                    
                }
            }
        default:
            EmptyView()
        }
    }
    
}

//struct PlaceDetailsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceDetailsContentView(viewModel: PlaceDetailsViewModel.Stub.Full())
//    }
//}
