//
//  TimeSensitiveTipView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 07/11/23.
//

import SwiftUI
import TipKit

struct TimeSensitiveTip:Tip {
    @Parameter static var hasTimeElapsed: Bool = false
    
    var title: Text = Text("Esvaziar")
    var message: Text? = Text("Aperte para esvaziar o copo")
    
    public mutating func delayText() async {
        try? await Task.sleep(nanoseconds: 10_000_000_000)
        TimeSensitiveTip.hasTimeElapsed = true
    }
    
    var rules: [Rule]{
        [
            #Rule(TimeSensitiveTip.$hasTimeElapsed) {
                $0 == true
            }
        ]
    }
}

struct TimeSensitiveTipView: View {
    
    @State var tip = TimeSensitiveTip()
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
            .popoverTip(tip)
            
            Spacer()
            
        }
        .padding()
        .onAppear{
            Task{
                try? Tips.configure([
                    .displayFrequency(.immediate),
                ])
                //                Tips.showAllTipsForTesting()
                await tip.delayText()
            }
        }
    }
}

#Preview {
    TimeSensitiveTipView()
}
