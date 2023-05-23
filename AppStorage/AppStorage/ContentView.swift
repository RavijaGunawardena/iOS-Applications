//
//  ContentView.swift
//  AppStorage
//
//  Created by Ravija Gunawardana on 2023-03-01.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("username") var name: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter your name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Button {
                // saving data into storage
//                UserDefaults.standard.setValue(name, forKey: "username")
            } label: {
                Text("Save")
            }

            Text("Your name is \(name)")
        }
        .padding()
        .onAppear{
            // loading data from storage
            // if not exists assign an empty string
//            name = UserDefaults.standard.string(forKey: "username") ?? ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
