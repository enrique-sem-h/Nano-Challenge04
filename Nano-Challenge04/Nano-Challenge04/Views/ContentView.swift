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
    
    init(cloudKitVM: CloudKitViewModel){
        _cloudKitVM = StateObject(wrappedValue: cloudKitVM)
        
    }
    @State var ml: Float = UserDefaults.standard.float(forKey: "ml") {
        didSet{
            UserDefaults.standard.set(self.ml, forKey: "ml")
        }
    }
    
    @State var copo: Int = UserDefaults.standard.integer(forKey: "cup"){
        didSet{
            UserDefaults.standard.setValue(self.copo, forKey: "cup")
        }
    }
    
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
                        Text(litros ? Strings.liters.rawValue : Strings.ml.rawValue)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .popoverTip(appOpenedTip)
                }.padding(.horizontal)
                
                Text(litros ? drankLiters : drankMilliliters)
                    .font(.largeTitle)
                    .bold()
                
                Button{
                    ml += Numbers.increment.rawValue
                    if copo <= Integers.cupLimit.rawValue {
                        copo += Integers.cupIncrement.rawValue
                    }
                    if Int(ml) % Integers.fullCup.rawValue == 0{
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
                
                Button(Strings.drain.rawValue){
                    copo = 0
                    ml = 0
                    cloudKitVM.saveCup(ml: ml)
                    timeSensitiveTip.invalidate(reason: .actionPerformed)
                }
                .buttonStyle(.borderedProminent)
                TipView(timeSensitiveTip, arrowEdge: .top) { action in
                    
                    if action.id == Strings.urlCheck.rawValue, let url = URL(string: Strings.link.rawValue) {
                        openURL(url) { accepted in
                            print(accepted ? Strings.success.rawValue : Strings.failure.rawValue)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button{
                                    TriggerTip.showTip = true
                                } label:{
                                    Image(systemName: "info.circle")
                                }
                                .popoverTip(triggerTip, arrowEdge: .top)
                            }
                        })
        }
        
        
        
        .onAppear {
            Task{
                await AppOpenedTip.numberOfTimesVisited.donate()
                await aa()
            }
        }
    }
    func aa() async{
        try? await Task.sleep(nanoseconds: 10_000_000_000)
        timeSensitiveTip.delayText()
    }
}

#Preview {
    ContentView(cloudKitVM: CloudKitViewModel(container: CKContainer.default()))
}

extension ContentView{
    enum Numbers: Float{
        case initial = 0
        case increment = 250
    }
    
    enum Integers: Int{
        case cupIncrement = 1
        case cupLimit = 10
        case fullCup = 3000
    }
    
    enum Strings: String{
        case ml = "ml"
        case liters = "litros"
        case drain = "Esvaziar"
        case urlCheck = "open-url"
        case link = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
        case success = "Success FAQ"
        case failure = "Failure"
    }
    
    var drankLiters: String{
        String(format: "%.2f litros bebidos", ml/1000)
    }
    
    var drankMilliliters: String{
        String(format: "%.f ml bebidos", ml)
    }
}
