//
//  PlaceDetailsView.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import SwiftUI
import MapKit

struct PlaceDetailsView<ViewModel: PlaceDetailsViewModelProtocol & ErrorViewDelegate>: View {
    
    // MARK: - Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: - View body
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .none:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(_):
                PlaceDetailsContentView(viewModel: viewModel)
            case .error(let error):
                ErrorView(
                    text: error.description,
                    description: nil,
                    delegate: viewModel
                )
            }
        }.task { await viewModel.getDetails() }
    }
}

//struct PlaceDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceDetailsView(viewModel: PlaceDetailsViewModel.Stub.Full())
//    }
//}
