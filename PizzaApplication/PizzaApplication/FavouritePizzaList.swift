//
//  FavouritePizzaList.swift
//  PizzaApplication
//
//  Created by Ravija Gunawardana on 2023-03-01.
//

import SwiftUI

struct FavouritePizzaList: View {
    
    @ObservedObject var viewModel: PizzaViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filterFavouritePizzas()) { pizza in
                    HStack {
                        Image("\(pizza.imageName ?? "")")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Text("\(pizza.name ?? "")")
                    }
                }
                .onDelete { indexSet in
                    viewModel.deletePizza(indexSet: indexSet)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favourite Pizzas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

//struct FavouritePizzaList_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritePizzaList(viewModel: PizzaViewModel())
//    }
//}
