//
//  TimeSensitiveTip.swift
//  Nano-Challenge04
//
//  Created by Victor Hugo Pacheco Araujo on 07/11/23.
//

import SwiftUI
import TipKit

struct AppOpenedTip: Tip {
  
  static var numberOfTimesVisited: Event = Event(id: "dev.victor.numberOfTimesVisited")
  
  var title: Text {
    Text("Clique no botão para mudar a medida").foregroundStyle(.indigo)
  }
  
  var message: Text? {
    Text("Ao clicar no botão você pode alternar entre miliLitros(mL) ou Litros(L)")
  }
  
  var image: Image? {
    Image(systemName: "drop")
  }
  
  var rules: [Rule] {
    return [
      #Rule(Self.numberOfTimesVisited) { $0.donations.count > 2 }
    ]
  }
  
}
