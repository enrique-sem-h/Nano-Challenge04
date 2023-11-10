//
//  OpenLinkTip.swift
//  Nano-Challenge04
//
//  Created by Gabriel Eirado on 09/11/23.
//

import Foundation
import TipKit

struct TouchDownTip: Tip {
    
    var title: Text {
        Text("hey there")
    }

    var message: Text? {
        Text("open the link!")
    }

    var image: Image? {
        Image(systemName: "star")
    }
    
    var options: [TipOption] {
        return [
            Tips.IgnoresDisplayFrequency(true)
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
