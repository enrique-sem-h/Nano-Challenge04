//
//  ContentView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var copo: Int = 0
    @State var ml: Float = 0
    @State var litros: Bool = false
    private var triggerTip = TriggerTip()
    
    var body: some View {
        NavigationStack{
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
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        TriggerTip.showTip = true
                    } label:{
                        Image(systemName: "info.circle")
                    }
                    .popoverTip(triggerTip, arrowEdge: .top)
                }
            })
        }
        .onTapGesture {
            TriggerTip.showTip = false
        }
        .task {
            try? Tips.configure()
        }
    }
}

#Preview {
    ContentView()
}
