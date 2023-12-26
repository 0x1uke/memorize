//
//  ContentView.swift
//  Memorize
//
//  Created by Luke 2023.
//

import SwiftUI

struct ContentView: View {
    
    struct Theme {
        var title: String
        var symbol: String
        var color: Color
        var emojis: Array<String>
    }
    
    // Create themes for matching game containing:
    // 1. Title (for button label)
    // 2. Symbol (for button icon)
    // 3. Color (for card color)
    // 4. Emojis (array of emojis that match the theme)
    let themes: [Theme] = [Theme(title: "Tech", symbol: "laptopcomputer", color: .purple, emojis: ["💻", "📀", "📸", "⌚️", "📱", "🎧",                          "📡"]),
                           Theme(title: "Cars", symbol: "car.fill", color: .red, emojis: ["🚗", "🚙", "🚑", "🚕", "🚓", "🚒", "🚛", "🛻"]),
                           Theme(title: "Beach", symbol: "beach.umbrella.fill", color: .cyan, emojis: ["☀️", "🌊", "🏖️", "🐚", "🐬", "🎣", "🏝️", "😎", "🐠", "🦈"])]
    
    @State var emojis: Array<String> = []
    @State var color = Color("black")
    
    // Create view with title, cards, and theme buttons
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            cards
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    // Generate grid of cards containing emojis from theme for matching with theme color
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 62.5))])
        {
            if(!emojis.isEmpty) {
                ForEach(0..<emojis.count, id: \.self) { index in
                    CardView(content: emojis[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .foregroundStyle(color)
    }
    
    // Generate a random number of pairs of cards matching theme in random order as an array
    func cardGenerator(content: Array<String>) -> Array<String> {
        var cards: Array<String> = []
        let pairs = Int.random(in: 4...12)
        for _ in 0..<pairs {
            let index = Int.random(in: 1..<content.count)
            cards.append(content[index])
            cards.append(content[index])
        }
        return cards.shuffled()
    }
    
    // Create the menu of buttons to select the different themes
    var themeButtons: some View {
        HStack (
            alignment: .bottom,
            spacing: 60
        ) {
            ForEach(0..<themes.count, id: \.self) { index in
                VStack {
                    Button(action: {
                        emojis = cardGenerator(content: themes[index].emojis)
                        color = themes[index].color
                    },
                           label: {
                        Label(themes[index].title, systemImage: themes[index].symbol)
                            .labelStyle(.iconOnly)
                            .font(.title)
                    })
                    Label(themes[index].title, systemImage: themes[index].symbol)
                        .labelStyle(.titleOnly)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
    
// Create the view with flipping logic
struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 0 : 1)
            base.fill().opacity(isFaceUp ? 1 : 0)
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
