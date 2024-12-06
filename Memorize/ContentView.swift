//
//  ContentView.swift
//  app test
//
//  Created by Rusty Dotson on 2024/11/14.
//

import SwiftUI


struct ContentView: View {
    
    let cardList: Array<String> = ["🇺🇸", "🍔", "🦅", "🧨", "🏈", "🐷", "⭐️", "💥"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            cardStack
            cardCountButtons
        }
    }
    
    var cardCountButtons: some View {
        HStack{
            cardAddButton
            Spacer()
            cardRemoveButton
            
        }.font(.largeTitle).padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        },  label: {
                Image(systemName: symbol)
        })
        .disabled(cardCount + offset == 0 || cardCount + offset == cardList.count)
    }
    
    var cardAddButton: some View {
        return cardCountAdjuster(by: 1, symbol: "plus.rectangle.portrait")
    }
    
    var cardRemoveButton: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.rectangle.portrait")
    }
    
    var cardStack: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(isFaceUp: false, content: cardList[index])
            }
        }.padding()
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
                Text("🇺🇸").font(.largeTitle)
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
