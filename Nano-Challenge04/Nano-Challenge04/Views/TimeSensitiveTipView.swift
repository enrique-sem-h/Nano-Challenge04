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
    
    var title: Text = Text("Tempo")
    var message: Text? = Text("teste")
    
    public mutating func delayText() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: 5_000_000_000)
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
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .popoverTip(tip)
        }.onAppear{
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
