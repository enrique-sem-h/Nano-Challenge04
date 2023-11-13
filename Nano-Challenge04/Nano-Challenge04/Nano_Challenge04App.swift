//
//  Nano_Challenge04App.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI
import TipKit
import CloudKit

@main
struct Nano_Challenge04App: App {
    
    let container = CKContainer(identifier: "iCloud.Nano04.CloudKit")
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
  var body: some Scene {
    WindowGroup {
      ContentView(cloudKitVM: CloudKitViewModel(container: container))
    }
  }
  
  init() {
    try? Tips.configure([ .displayFrequency(.immediate), .datastoreLocation(.applicationDefault)])
  }
  
}
