//
//  MapAnnotationImage.swift
//  Felix
//
//  Created by Alexey Sigay on 30.04.2023.
//

import SwiftUI

struct MapAnnotationImage: View {
    var body: some View {
        Image(systemName: "mappin.circle.fill")
            .resizable()
            .background(.white)
            .clipShape(Circle())
            .foregroundColor(.red)
            .frame(width: 44, height: 44)
    }
}

struct MapAnnotationImage_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationImage()
    }
}
