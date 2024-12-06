//
//  ContentView.swift
//  app test
//
//  Created by Rusty Dotson on 2024/11/14.
//

import SwiftUI


struct ContentView: View {
    
    
    
    var body: some View {
        HStack{
            let cardList: Array<String> = ["🇺🇸", "🍔", "🦅", "🧨", "🏈"]
            ForEach(cardList.indices, id: \.self) {index in
                CardView(isFaceUp: false, content: cardList[index])
            }
        }
        .padding()
    }
}

struct CardView: View {
    
    @State var isFaceUp = false
    @State var content: String = "🇺🇸"
    
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerRadius: 15)
            if isFaceUp {
                cardBase
                    .foregroundColor(.white)
                cardBase
                    .strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            } else {
                cardBase
            }
        }
        .foregroundColor(.red)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
