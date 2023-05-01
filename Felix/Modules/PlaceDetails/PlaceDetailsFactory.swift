//
//  PlaceDetailsFactory.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import SwiftUI

struct PlaceDetailsFactory {
    @MainActor
    static func create(placeID: String) -> some View {
        let viewModel = PlaceDetailsViewModel(
            networkService: NetworkService.shared,
            placeID: placeID
        )
        return PlaceDetailsView(viewModel: viewModel)
    }
}
