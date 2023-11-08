//
//  TriggerTipView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 07/11/23.
//

import SwiftUI
import TipKit

struct TriggerTip: Tip {
    @Parameter
    static var showTip: Bool = false
    
    var title: Text {
        Text("Info")
    }

    var message: Text?{
        Text("Clique no copo para adicional 250ml de água bebida ou no botão esvaziar para esvaziar o copo e recomeçar a contagem")
    }

    var image: Image? {
        Image(systemName: "info.bubble")
    }
    
    var options: [TipOption] {
        return [
            Tips.IgnoresDisplayFrequency(true)
        ]
    }
    
    var rules: [Rule] {
        return [
            #Rule(Self.$showTip) { $0 == true }
        ]
    }
    
}
