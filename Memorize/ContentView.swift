//
//  ContentView.swift
//  app test
//
//  Created by Rusty Dotson on 2024/11/14.
//

import SwiftUI


struct ContentView: View {
    
    
    let themes: [[String]] = [["🇺🇸", "🍔", "🦅", "🧨", "🏈"], ["☺️", "🥺", "😂", "🙂‍↔️", "🤨", "😗"], ["🐬", "🐒", "🐶", "🐥", "🦅", "🦆", "🐞"]]
    let themeColors: [[Color]] = [[.blue, .red], [.white, .yellow], [.teal, .green]]
    @State var cardList: Array<String> = ["🇺🇸", "🍔", "🦅", "🧨", "🏈", "🇺🇸", "🍔", "🦅", "🧨", "🏈"].shuffled()
    @State var themeColor: [Color] = [.blue, .red]
    
    
    var body: some View {
        
        VStack {
            Text("Memorize!!").font(.largeTitle).padding()
            themeSelector
            ScrollView{
                cardStack
            }
            Spacer()
            
        }
    }
    
    var themeSelector: some View {
        
        let themeButtonLogos: [String] = ["american.football.fill", "face.smiling.inverse", "bird.fill"]
        
        return HStack {
            ForEach (0..<3) {index in
                Spacer()
                Button (action: {
                    cardList = (themes[index] + themes[index]).shuffled()
                    themeColor = themeColors[index]
                }, label: {
                    Image(systemName: themeButtonLogos[index])
                        .renderingMode(.template)
                        .foregroundColor(themeColors[index][1])
                        .imageScale(.large)
                        .font(.largeTitle)
                        .padding()
                })
                Spacer()
            }
        }
    }
    
    var cardStack: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]){
            ForEach(cardList.indices, id: \.self) { index in
                CardView(isFaceUp: false, content: $cardList[index], cardColor: $themeColor).aspectRatio(2/3, contentMode: .fit)
            }
        }.padding()
    }
}


struct CardView: View {
    
    @State var isFaceUp = false
    @Binding var content: String
    @Binding var cardColor: [Color]
    
    var body: some View {
        ZStack {
            let cardBase = RoundedRectangle(cornerRadius: 15)
            
            Group {
                cardBase
                    .foregroundColor(cardColor[0])
                cardBase
                    .strokeBorder(lineWidth: 4).foregroundColor(cardColor[1])
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            cardBase.opacity(isFaceUp ? 0 : 1)
        }
        .foregroundColor(cardColor[1])
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
    
    func setLogo(logo: String) {
        
    }
}


#Preview {
    ContentView()
}
