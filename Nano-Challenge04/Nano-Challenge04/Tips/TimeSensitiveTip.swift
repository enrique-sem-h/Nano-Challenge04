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
    
    public mutating func delayText() {
            TimeSensitiveTip.hasTimeElapsed = true
    }
    
    var rules: [Rule]{
        [
            #Rule(TimeSensitiveTip.$hasTimeElapsed) {
                $0 == true
            }
        ]
    }
  
  var actions: [Action] {
          [
              Tip.Action(
                  id: "open-url",
                  title: "open link"
              )
          ]
      }
}

//@MainActor
//extension Binding where Value == TimeSensitiveTip{
//    func waitTime() async{
//        await wrappedValue.delayText()
//    }
//}
