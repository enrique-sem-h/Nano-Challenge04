//
//  TimeSensitiveTip.swift
//  Nano-Challenge04
//
//  Created by Victor Hugo Pacheco Araujo on 07/11/23.
//

import SwiftUI
import TipKit

struct AppOpenedTip: Tip {
  
  // variavel event que permite contar o numero de vezes que a view foi aberta
  static var numberOfTimesVisited: Event = Event(id: "dev.victor.numberOfTimesVisited")
  
  // titulo da tip
  var title: Text {
    Text("Clique no botão para mudar a medida").foregroundStyle(.indigo)
  }
  
  // mensagem do corpo da tip
  var message: Text? {
    Text("Ao clicar no botão você pode alternar entre miliLitros(mL) ou Litros(L)")
  }
  
  // imagem que aparece na tip
  var image: Image? {
    Image(systemName: "drop")
  }
  
  // regra para aparição da tip, que no caso aparece após a view aparecer 2 vezes, ou seja, na terceira vez.
  var rules: [Rule] {
    return [
      #Rule(Self.numberOfTimesVisited) { $0.donations.count > 2 }
    ]
  }
  
}
