//
//  ContentView.swift
//  QuadraticSolver
//
//  Created by Ravija Gunawardana on 2023-02-24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("firstTerm") private var firstTerm = ""
    @AppStorage("secondTerm") private var secondTerm = ""
    @AppStorage("thirdTerm") private var thirdTerm = ""
    
    @AppStorage("x1") private var x1 = ""
    @AppStorage("x2") private var x2 = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Quadratic Solver")
                    .font(.title)
                
                Text("The quadratic form is:")
                
                Image("quadraticForm")
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Label("Enter the first term", systemImage: "a.circle.fill")
                    
                    TextField("", text: $firstTerm)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                    
                    Label("Enter the second term", systemImage: "b.circle.fill")
                    
                    TextField("", text: $secondTerm)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                    
                    Label("Enter the third term", systemImage: "c.circle.fill")
                    
                    TextField("", text: $thirdTerm)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    solveForX()
                } label: {
                    Text("Solve for X")
                }
                
                Text("x = \(x1), x = \(x2)")
                
                Spacer()
            }
            .padding()
        }
    }
    
    func solveForX() {
        guard let firstTerm = Double(firstTerm),
                let secondTerm = Double(secondTerm),
                let thridTerm = Double(thirdTerm) else { return }
        
        let bSquared = secondTerm * secondTerm
        let discriminant = bSquared - (4 * firstTerm * thridTerm)
        let discrimimantAbsSqrt = sqrt(fabs(discriminant))
        
        let topFormula1 = -secondTerm + discrimimantAbsSqrt
        let topFormula2 = -secondTerm - discrimimantAbsSqrt
        
        let bottomFormula = 2 * firstTerm
        
        let totalX1 = topFormula1 / bottomFormula
        let totalX2 = topFormula2 / bottomFormula
        
        x1 = String(format: "%.2f", totalX1)
        x2 = String(format: "%.2f", totalX2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
