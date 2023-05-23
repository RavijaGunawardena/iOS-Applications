//
//  ContentView.swift
//  RightTriangleProblemSolver
//
//  Created by Ravija Gunawardana on 2023-03-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalculationView()
                .tabItem {
                    Label("Calculation", systemImage: "sum")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "list.dash")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
