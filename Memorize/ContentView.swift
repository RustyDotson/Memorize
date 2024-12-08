//
//  ContentView.swift
//  app test
//
//  Created by Rusty Dotson on 2024/11/14.
//

import SwiftUI


struct ContentView: View {
    
    
    let themes: [[String]] = [["🇺🇸", "🍔", "🦅", "🧨", "🏈", "🐷", "⭐️"], ["☺️", "🥺", "😂", "🙂‍↔️", "🤨", "😗", "🥲"], ["🐬", "🐒", "🐶", "🐥", "🦅", "🦆", "🐞"]]
    @State var cardList: Array<String> = ["🇺🇸", "🍔", "🦅", "🧨", "🏈", "🐷", "⭐️", "💥"]
    @State var cardCount: Int = 5
    
    
    var body: some View {
        
        VStack {
            Text("Memorize!!").font(.largeTitle).padding()
            themeSelector
            ScrollView{
                cardStack
            }
            Spacer()
            cardCountButtons
            
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offset
        },  label: {
                Image(systemName: symbol)
        })
        .disabled(cardCount + offset == 0 || cardCount + offset == cardList.count+1)
    }
    
    var cardCountButtons: some View {
            HStack{
                cardAddButton
                Spacer()
                cardRemoveButton
                
            }.font(.largeTitle).padding()
        }
        
    var cardAddButton: some View {
        return cardCountAdjuster(by: 1, symbol: "plus.rectangle.portrait")
    }
    
    var cardRemoveButton: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.rectangle.portrait")
    }
    
    var themeSelector: some View {
        
        let themeButtonLogos: [String] = ["american.football.fill", "face.smiling.inverse", "bird.fill"]
        let themeCardCount: [Int] = [4, 5, 6]
        
        return HStack {
            ForEach (0..<3) {index in
                Spacer()
                Button (action: {
                    cardCount = themeCardCount[index]
                    cardList = themes[index]
                }, label: {
                    Image(systemName: themeButtonLogos[index]).imageScale(.large).font(.largeTitle).padding()
                })
                Spacer()
            }
        }
    }
    
    var cardStack: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(isFaceUp: false, cardLogos: $cardList, logoIndex: index).aspectRatio(2/3, contentMode: .fit)
            }
        }.padding()
    }
}


struct CardView: View {
    
    @State var isFaceUp = false
    @Binding var cardLogos: [String]
    @State var logoIndex: Int = 0
    
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerRadius: 15)
            
            Group {
                cardBase
                    .foregroundColor(.white)
                cardBase
                    .strokeBorder(lineWidth: 4)
                Text(cardLogos[logoIndex]).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            cardBase.opacity(isFaceUp ? 0 : 1)
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
