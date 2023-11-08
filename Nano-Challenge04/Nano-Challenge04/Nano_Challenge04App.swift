//
//  Nano_Challenge04App.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI
import TipKit

@main
struct Nano_Challenge04App: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
  
  init() {
    try? Tips.configure([ .displayFrequency(.immediate), .datastoreLocation(.applicationDefault)])
  }
  
}
