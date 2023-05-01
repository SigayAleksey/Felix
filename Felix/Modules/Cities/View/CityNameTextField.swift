//
//  CityNameTextField.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import SwiftUI

struct CityNameTextField<ViewModel: CitiesViewModelProtocol>: View {
    
    // MARK: - Properties
    
    var viewModel: ViewModel
    
    // MARK: - Private roperties
    
    @State private var cityName: String = ""
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            VStack{
                HStack {
                    Spacer(minLength: 20)
                    TextField("City", text: $cityName)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            Task {
                                await viewModel.getCities(name: cityName)
                            }
                        }
                    Spacer(minLength: 20)
                }
                Spacer()
            }
        }
    }
}

struct CityNameTextField_Previews: PreviewProvider {
    static var previews: some View {
        CityNameTextField(viewModel: CitiesViewModel.Stub.Empty())
            .previewDisplayName("Empty")
    }
}
