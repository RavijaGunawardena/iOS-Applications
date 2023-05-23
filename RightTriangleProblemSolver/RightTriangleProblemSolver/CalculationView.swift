//
//  CalculationView.swift
//  RightTriangleProblemSolver
//
//  Created by Ravija Gunawardana on 2023-03-17.
//

import SwiftUI

struct CalculationView: View {
    
    @State private var selectedItem: Int = 0
    @State private var selectedItemName = ""
    @State private var baseTextFiled = ""
    @State private var altitudeTextFiled = ""
    @State private var hypotenuseTextFiled = ""
    @State private var displayMode = false
    @State private var calculatedUnkownValue = ""
    
    @AppStorage("Base") private var baseAppStorage = ""
    @AppStorage("Altitude") private var altitudeAppStorage = ""
    @AppStorage("Hypotenuse") private var hypotenuseAppStorage = ""
    
    @AppStorage("Area") private var calculatedAreaValue = ""
    @AppStorage("Perimeter") private var calculatedPerimeterValue = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image("right_triangle")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                HStack(alignment: .center) {
                    Text("Choose the unkown edge")
                        .bold()
                    
                    Picker("Please choose an edge", selection: $selectedItem) {
                        Text("Base").tag(0)
                        Text("Altitude").tag(1)
                        Text("Hypotenuse").tag(2)
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: selectedItem) { _ in
                        displayMode = false
                        baseTextFiled = ""
                        altitudeTextFiled = ""
                        hypotenuseTextFiled = ""
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Enter the known lengths")
                        .bold()
                    
                    if selectedItem == 0 {
                        TextField("Altitude Value", text: $altitudeTextFiled)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Hypotenuse Value", text: $hypotenuseTextFiled)
                            .textFieldStyle(.roundedBorder)
                    } else if selectedItem == 1 {
                        TextField("Base Value", text: $baseTextFiled)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Hypotenuse Value", text: $hypotenuseTextFiled)
                            .textFieldStyle(.roundedBorder)
                    } else {
                        TextField("Base Value", text: $baseTextFiled)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Altitude Value", text: $altitudeTextFiled)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                Button {
                    displayMode = true
                    calculateUnkownEdgeLength()
                } label: {
                    Text("Calculate")
                        .font(.subheadline.bold())
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(15)
                }
                .padding()

                if displayMode {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Calculated ouput")
                            .bold()
                        
                        HStack {
                            Text(selectedItemName)
                            Spacer()
                            Text(calculatedUnkownValue)
                        }
                        
                        HStack {
                            Text("Area")
                            Spacer()
                            Text(calculatedAreaValue)
                        }
                        
                        HStack {
                            Text("Perimeter")
                            Spacer()
                            Text(calculatedPerimeterValue)
                        }
                    }
                    .bold()
                }
            }
            .padding()
            .navigationTitle("Triangle Calculator")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func calculateUnkownEdgeLength() {
        switch selectedItem {
        case 0:
            guard let altitudeValue = Double(altitudeTextFiled), let hypotenuseValue = Double(hypotenuseTextFiled) else { return }
            let unkownValue = (pow(hypotenuseValue, 2) - pow(altitudeValue, 2)).squareRoot()
            selectedItemName = "Base"
            calculatedUnkownValue = String(format: "%.2f", unkownValue)
            calculateArea(altitude: altitudeValue, base: unkownValue)
            calculatePerimeter(altitude: altitudeValue, base: unkownValue)
            baseAppStorage = calculatedUnkownValue
            altitudeAppStorage = String(altitudeValue)
            hypotenuseAppStorage = String(hypotenuseValue)
        case 1:
            guard let baseValue = Double(baseTextFiled), let hypotenuseValue = Double(hypotenuseTextFiled) else { return }
            let unkownValue = (pow(hypotenuseValue, 2) - pow(baseValue, 2)).squareRoot()
            selectedItemName = "Altitude"
            calculatedUnkownValue = String(format: "%.2f", unkownValue)
            calculateArea(altitude: unkownValue, base: baseValue)
            calculatePerimeter(altitude: unkownValue, base: baseValue)
            baseAppStorage = String(baseValue)
            altitudeAppStorage = calculatedUnkownValue
            hypotenuseAppStorage = String(hypotenuseValue)
        default:
            guard let baseValue = Double(baseTextFiled), let altitudeValue = Double(altitudeTextFiled) else { return }
            let unkownValue = (pow(baseValue, 2) + pow(altitudeValue, 2)).squareRoot()
            selectedItemName = "Hypotenuse"
            calculatedUnkownValue = String(format: "%.2f", unkownValue)
            calculateArea(altitude: altitudeValue, base: baseValue)
            calculatePerimeter(altitude: altitudeValue, base: baseValue)
            baseAppStorage = String(baseValue)
            altitudeAppStorage = String(altitudeValue)
            hypotenuseAppStorage = calculatedUnkownValue
        }
    }
    
    func calculateArea(altitude: Double, base: Double) {
        let area = (altitude * base) / 2
        calculatedAreaValue = String(format: "%.2f", area)
    }
    
    func calculatePerimeter(altitude: Double, base: Double) {
        let perimeter = altitude + base + (pow(altitude, 2) + pow(base, 2)).squareRoot()
        calculatedPerimeterValue = String(format: "%.2f", perimeter)
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView()
    }
}
