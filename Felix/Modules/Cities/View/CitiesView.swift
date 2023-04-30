//
//  CitiesView.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import SwiftUI
import MapKit

struct CitiesView<ViewModel: CitiesViewModelProtocol & MapZoomButtonsProtocol & ErrorViewDelegate>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .none:
                    CitiesMapView(viewModel: viewModel)
                case .loading:
                    ProgressView()
                case .success(_):
                    CitiesMapView(viewModel: viewModel)
                case .error(let error):
                    ErrorView(
                        text: error.description,
                        description: nil,
                        delegate: viewModel
                    )
                }
            }
            
            CityNameTextField(viewModel: viewModel)
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(viewModel: CitiesViewModel.Stub.Full())
            .previewDisplayName("Full")
        
        CitiesView(viewModel: CitiesViewModel.Stub.Empty())
            .previewDisplayName("Empty")
        
        CitiesView(viewModel: CitiesViewModel.Stub.Error())
            .previewDisplayName("Error")
    }
}
