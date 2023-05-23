//
//  SinglePizzaView.swift
//  PizzaApplication
//
//  Created by Ravija Gunawardana on 2023-03-10.
//

import SwiftUI

struct SinglePizzaView: View {
    
    var selectedPizzaItem: PizzaEntity
    @ObservedObject var viewModel: PizzaViewModel
    @State var isFavourite: Bool
    
    init(selectedPizzaItem: PizzaEntity, viewModel: PizzaViewModel) {
        self.selectedPizzaItem = selectedPizzaItem
        self.viewModel = viewModel
        self.isFavourite = selectedPizzaItem.isFavourite
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("\(selectedPizzaItem.imageName ?? "")")
                    .resizable()
                    .frame(height: 200)
                
                Form {
                    Section {
                        Text("\(selectedPizzaItem.ingredients ?? "")")
                            .multilineTextAlignment(.leading)
                    } header: {
                        Text("Ingredients")
                    }

                    Toggle("Favourite", isOn: $isFavourite).onChange(of: isFavourite) { newValue in
                        viewModel.updateIsFavourite(entity: selectedPizzaItem, isFavourite: isFavourite)
                    }
                }
            }
            .navigationTitle("\(selectedPizzaItem.name ?? "")")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

//struct SinglePizzaView_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePizzaView(selectedPizzaItem: PizzaEntity(), viewModel: PizzaViewModel())
//    }
//}
