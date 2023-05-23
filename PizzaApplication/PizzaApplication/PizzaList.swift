//
//  PizzaList.swift
//  PizzaApplication
//
//  Created by Ravija Gunawardana on 2023-03-01.
//

import SwiftUI

struct PizzaList: View {
    
    @ObservedObject var viewModel: PizzaViewModel
    
    @State private var selectedIndex = 0
    @State private var isSheetShowing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Pizza", selection: $selectedIndex) {
                    Text("All 🍕").tag(0)
                    Text("Meat 🥩").tag(1)
                    Text("Veggie 🥦").tag(2)
                }
                .pickerStyle(.segmented)
                
                List {
                    if selectedIndex == 0 {
                        ForEach(viewModel.savedPizzaData) { pizza in
                            NavigationLink {
                                SinglePizzaView(selectedPizzaItem: pizza, viewModel: viewModel)
                            } label: {
                                HStack {
                                    Image("\(pizza.imageName ?? "")")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Text("\(pizza.name ?? "")")
                                    
//                                    Text("\(pizza.isFavourite.description)")
                                }
                            }
                        }
                    } else if selectedIndex == 1 {
                        ForEach(viewModel.filterPizzaWithType(pizzaType: "meat")) { pizza in
                            HStack {
                                Image("\(pizza.imageName ?? "")")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Text("\(pizza.name ?? "")")
                            }
                        }
                    } else {
                        ForEach(viewModel.filterPizzaWithType(pizzaType: "vegetarian")) { pizza in
                            HStack {
                                Image("\(pizza.imageName ?? "")")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Text("\(pizza.name ?? "")")
                            }
                        }
                    }
                    
                    
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isSheetShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                AddNewPizza(viewModel: viewModel)
            }
            .navigationTitle("Pizza List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct PizzaList_Previews: PreviewProvider {
    static var previews: some View {
        PizzaList(viewModel: PizzaViewModel())
    }
}
