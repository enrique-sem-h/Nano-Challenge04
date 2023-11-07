//
//  ContentView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var copo: Int = 0
    @State var ml: Float = 0
    @State var litros: Bool = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $litros) {
                Text(litros ? "litros" : "ml")
                    .font(.title2)
                    .bold()
            }
            Text(litros ? String(format: "%.2f litros bebidos", ml/1000) : String(format: "%.f ml bebidos", ml))
                .font(.largeTitle)
                .bold()
            Button{
                ml += 250
                if copo <= 10 {
                    copo += 1
                }
            } label: {
                CopoView(copo: copo)
            }
            Button("Esvaziar"){
                copo = 0
                ml = 0
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    ContentView(copo: 0)
}
