//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack {
            
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            // Use ZStack for background images
            
            VStack(spacing: 20) {
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom:50, trailing: 0))
                        
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                    
                }
                
                HStack (spacing: 40){
                    Text("H: \((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                        .foregroundColor(.black)
                    
                    Text("L: \((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                    
                }
                
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
               
                Text("Air Quality Data:")
                    .font(.title)
                    .bold()
                
                // images
                HStack (spacing: 40){
                    VStack(spacing: 20) {
                        Image("so2").resizable().scaledToFit().frame(width: 50,height: 50)
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.so2 ?? 0.0))
                    }
                    VStack(spacing: 20) {
                        Image("no").resizable().scaledToFit().frame(width: 50,height: 50)
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.no ?? 0.0))
                    }
                    VStack(spacing: 20) {
                        Image("voc").resizable().scaledToFit().frame(width: 50,height: 50)
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.co ?? 0.0))
                    }
                    VStack(spacing: 20) {
                        Image("pm").resizable().scaledToFit().frame(width: 50,height: 50)
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.pm10 ?? 0.0))
                    }
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .onAppear{
            Task{
               try await modelData.loadAirData()
            }
        }
        
    }
}



