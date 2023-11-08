//
//  AppOpenedTipView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 07/11/23.
//

import SwiftUI

struct AppOpenedTipView: View {
  private var appOpenedTip = AppOpenedTip()
  
  @State var copo: Int = 0
  @State var ml: Float = 0
  @State var litros: Bool = false
    var body: some View {
      
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
        } label: {
          CopoView(copo: copo)
        }
        Button("Esvaziar"){
          copo = 0
          ml = 0
        }
        .buttonStyle(.borderedProminent)
        
        Spacer()
        
      }
      .onAppear(perform: {
        Task{
          await AppOpenedTip.numberOfTimesVisited.donate()
        }
        
      })
      
      .padding()
      
    }
}

#Preview {
    AppOpenedTipView()
}
