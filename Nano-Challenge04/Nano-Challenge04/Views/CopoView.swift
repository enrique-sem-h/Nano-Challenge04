//
//  CopoView.swift
//  Nano-Challenge04
//
//  Created by Letícia Malagutti on 06/11/23.
//

import SwiftUI

struct CopoView: View {
    var copo: Int
    
    var body: some View {
        VStack{
            
            Image(defineCopo(copo: copo))
                .resizable()
                .frame(width: 300, height: 300)

        }
        .padding()
    }
    
    func defineCopo(copo: Int) -> String{
        switch copo {
        case 1:
            "Copo=10%"
        case 2:
            "Copo=20%"
        case 3:
            "Copo=30%"
        case 4:
            "Copo=40%"
        case 5:
            "Copo=50%"
        case 6:
            "Copo=60%"
        case 7:
            "Copo=70%"
        case 8:
            "Copo=80%"
        case 9:
            "Copo=90%"
        case 10:
            "Copo=100%"
        case 11:
            "Copo=Overload"
        default:
            "Copo=Vazio"
        }
    }
}

#Preview {
    CopoView(copo: 10)
}
