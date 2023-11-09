//
//  OpenLinkTip.swift
//  Nano-Challenge04
//
//  Created by Gabriel Eirado on 09/11/23.
//

import Foundation
import TipKit

struct ToutchDownTip: Tip {
    @Parameter
    static var showTip: Bool = false
    
    var title: Text {
        Text("Save as a Favorite")
    }

    var message: Text? {
        Text("Your favorite landmarks always appear at the top of the list.")
    }

    var image: Image? {
        Image(systemName: "star")
    }
    
    var options: [TipOption] {
        return [
            Tips.IgnoresDisplayFrequency(true)
        ]
    }
    
    var rules: [Rule] {
        return [
            #Rule(Self.$showTip) { $0 == false }
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
