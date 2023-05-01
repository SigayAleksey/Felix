//
//  CityDetailsView.swift
//  Felix
//
//  Created by Alexey Sigay on 01.05.2023.
//

import SwiftUI

struct CityDetailsView: View {
    
    // MARK: - Properties
    
    let city: City
    
    @State private var path = NavigationPath()
    
    // MARK: - View body
    
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            VStack(spacing: 16) {
                Text(city.name)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Population: \(city.population)")
                    }
                    Spacer()
                }
                NavigationLink("Details") {
                    PlaceDetailsFactory.create(placeID: city.country.id)
                } 
            }
            Spacer(minLength: 20)
        }
    }
}

struct CityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailsView(city: City.Stub.city1)
    }
}
