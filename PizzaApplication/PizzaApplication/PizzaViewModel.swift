//
//  PizzaViewModel.swift
//  PizzaApplication
//
//  Created by Ravija Gunawardana on 2023-03-10.
//

import Foundation
import CoreData

class PizzaViewModel: ObservableObject {
    
    @Published var savedPizzaData: [PizzaEntity] = []
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "PizzaDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error in loading core data. \(error)")
            } else {
                print("Successfully loaded core data.")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<PizzaEntity>(entityName: "PizzaEntity")
        do {
            savedPizzaData = try container.viewContext.fetch(request)
        } catch let error {
            print("Error in fetching data. \(error)")
        }
    }
    
    func addPizzaData(name: String, ingredients: String, imageName: String, pizzaType: String, isFavourite: Bool) {
        let newPizza = PizzaEntity(context: container.viewContext)
        newPizza.name = name
        newPizza.ingredients = ingredients
        newPizza.imageName = imageName
        newPizza.pizzaType = pizzaType
        newPizza.isFavourite = isFavourite
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("Error while saving data. \(error)")
        }
    }
    
    func filterPizzaWithType(pizzaType: String) -> [PizzaEntity] {
        return savedPizzaData.filter { $0.pizzaType == pizzaType }
    }
    
    func filterFavouritePizzas() -> [PizzaEntity] {
        return savedPizzaData.filter { $0.isFavourite == true }
    }
    
    func updateIsFavourite(entity: PizzaEntity, isFavourite: Bool) {
        entity.isFavourite = isFavourite
        saveData()
    }
    
    func deletePizza(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let pizzaEnity = savedPizzaData[index]
        container.viewContext.delete(pizzaEnity)
        saveData()
    }
}
