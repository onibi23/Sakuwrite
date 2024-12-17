//
//  FavouritesView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//



// FavouritesView.swift
import SwiftUI

struct FavouritesView: View {
    @State private var favourites = [
        "Sunset at the beach",
        "Mountain hike with friends",
        "Coffee on a rainy day",
        "Reading by the fireplace",
        "Stargazing on a clear night"
    ]

    var body: some View {
        VStack {
            // Title
            Text("Favourites")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer().frame(height: 20) // To add spacing below the title
            
            // List of favourite entries
            List(favourites, id: \.self) { favourite in
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                    Text(favourite)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .padding(.horizontal)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}

