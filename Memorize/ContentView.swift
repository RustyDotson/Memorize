//
//  ContentView.swift
//  Memorize
//
//  Created by Rusty Dotson on 2024/12/04.
//ß
import SwiftUI


struct CardView: View{
    
    //is the card face up or down.
    @State var isFaceUp: Bool = false
    @Binding var numOfFaceUp: Int
    @Binding var selectedCards: [String]
    var faceUpColor: Color = .gray
    var faceDownColor: Color = .green
    var faceDown: String = ""
    var faceUp: String = ""
    @State var isComplete = false
    @Binding var completedCards: [String]
    
    //binded to the ContentView parent view.
    //@Binding var theme: CardTheme
    //var faceUpIndex: Int
    
    
    var body: some View{
        Text(String(isFaceUp))
        if isFaceUp == false {
            faceDownCard.onTapGesture {
                selectedCards = selectedCards + [self.faceUp]
                isFaceUp.toggle()
            }
        }
        else {
            faceUpCard
        }
    }

        
    
    
    var faceDownCard: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(lineWidth: 5, antialiased: true)
                .foregroundColor(faceUpColor)
            Text(faceDown)
        }
        .foregroundColor(faceDownColor)
    }
        
    
    var faceUpCard: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(lineWidth: 5, antialiased: true)
                .foregroundColor(faceDownColor)
            Text(faceUp)
            
        }
        .foregroundColor(faceUpColor)
    }
}


struct ContentView: View {
    
    let themesFaceUp: [[String]] =  [["🦅", "🧨", "🏈", "🍔"],
                              ["💕", "🩰", "🥚", "🎨", "🐭"],
                              ["🤖", "👻", "👽", "📟", "☺️", "🐨"]]
    @State var currentTheme:  [String] = []
    @State var numOfFaceUp:   Int = 0
    @State var selected:      [String] = []
    @State var completed:     [String] = []
    
    
    
    
    var body: some View {
        Text("Memorize")
            .font(.largeTitle)

        
        VStack {
            HStack {
                ForEach(0..<themesFaceUp.count, id: \.self){ index in
                    Button(String(themesFaceUp[index][0])){
                        currentTheme = (themesFaceUp[index] + themesFaceUp[index])//.shuffled()
                    }.padding().font(.largeTitle)
                }
            }.padding()
            
            
                
                let columns = [GridItem(.adaptive(minimum: 150), spacing:50)]
                
                //HStack {
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(0..<currentTheme.count, id: \.self){ index in
                        VStack {
                            CardView(isFaceUp: false, numOfFaceUp: $numOfFaceUp, selectedCards: $selected, faceUp: currentTheme[index], completedCards: $completed).aspectRatio(2/3, contentMode: .fit)
                            }
                        }.padding()
                    }
                }.padding(10)
            }
        }
    }


#Preview {
    ContentView()
}
