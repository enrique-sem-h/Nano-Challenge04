//
//  ContentView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI
import TipKit
import CloudKit

struct ContentView: View {
    @StateObject private var cloudKitVM: CloudKitViewModel
    @State var ml: Float = 0

    init(cloudKitVM: CloudKitViewModel){
        _cloudKitVM = StateObject(wrappedValue: cloudKitVM)
        
    }

    @State var copo: Int = 0


    @State var litros: Bool = false

    // tips
    private var triggerTip = TriggerTip()
    @State var timeSensitiveTip = TimeSensitiveTip()
    private var appOpenedTip = AppOpenedTip()
    private let onboardingTip = OnboardingTip()
    let touchDownTip = TouchDownTip()

    @Environment(\.openURL) private var openURL

    
    var body: some View {
        NavigationStack{
            VStack {
              HStack {
                
                Spacer()
                
                Button {
                  litros.toggle()
                  appOpenedTip.invalidate(reason: .actionPerformed)
                } label: {
                  Text(litros ? "litros" : "ml")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                }
                .popoverTip(appOpenedTip)
              }.padding(.horizontal)
              
                Text(litros ? String(format: "%.2f litros bebidos", ml/1000) : String(format: "%.f ml bebidos", ml))
                    .font(.largeTitle)
                    .bold()
              
                Button{
                    ml += 250
                    if copo <= 10 {
                        copo += 1
                    }
                    if ml >= 3000{
                        cloudKitVM.saveCup(ml: ml)
                    }
                    if onboardingTip.shouldDisplay{
                        onboardingTip.invalidate(reason: .actionPerformed)
                    }
                } label: {
                    CopoView(copo: copo)
                }
              
            TipView(onboardingTip, arrowEdge: .top)
                .tipViewStyle(OnboardingStyle())
            
            Button("Esvaziar"){
                copo = 0
                ml = 0
                cloudKitVM.saveCup(ml: ml)
//              timeSensitiveTip.invalidate(reason: .actionPerformed)
            }
            .buttonStyle(.borderedProminent)
              TipView(timeSensitiveTip, arrowEdge: .top) { action in

                  if action.id == "open-url", let url = URL(string: "https://www.youtube.com/watch?v=5T5BY1j2MkE&ab_channel=RoastedCurry") {
                      openURL(url) { accepted in
                          print(accepted ? "Success FAQ" : "Failure")
                      }
                  }
              }
              
            Spacer()
        }
            .padding()
//            .toolbar(content: {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button{
//                        TriggerTip.showTip = true
//                    } label:{
//                        Image(systemName: "info.circle")
//                    }
//                    .popoverTip(triggerTip, arrowEdge: .top)
//                }
//            })
        }


        .task {
          
        }
      
        .onAppear {
          Task{
            await timeSenseitiveAwait()
            await AppOpenedTip.numberOfTimesVisited.donate()
              await cloudKitVM.aaa()
              ml = cloudKitVM.ml
          }
        }
    }
    
    func timeSenseitiveAwait() async {
        try? await Task.sleep(nanoseconds: 10_000_000_000)
        timeSensitiveTip.delayText()
    }
}

#Preview {
    ContentView(cloudKitVM: CloudKitViewModel(container: CKContainer.default()))
}
