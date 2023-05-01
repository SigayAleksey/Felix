//
//  CitiesFactory.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import SwiftUI

struct CitiesFactory {
    @MainActor
    static func create() -> some View {
        let viewModel = CitiesViewModel(
            networkService: NetworkService.shared
        )
        return CitiesView(viewModel: viewModel)
    }
}
