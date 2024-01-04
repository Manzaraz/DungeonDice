//
//  ContentView.swift
//  DungeonDice
//
//  Created by Christian Manzaraz on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
    @State private var buttonsLeftOver = 0 // # of buttons in a less-than-full row
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0 // Between buttons
    let buttonWidth: CGFloat = 115
    
    var body: some View {
        GeometryReader(content: { geo in
            VStack {
                
                Text("Dungeon Dice")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.red)
                
                Spacer()
                
                Text(resultMessage)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(height: 150)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                        }
                        .frame(width: buttonWidth)
                    }
                    
                }
                
                HStack(alignment: .center, content: {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                        }
                        .frame(width: buttonWidth)
                    }
                })
                
            }
            .padding()
            .onChange(of: geo.size.width, {
                arrangeGridItems(geo: geo)
            })
            .onAppear{
                arrangeGridItems(geo: geo)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        })
    }
    
    func arrangeGridItems(geo: GeometryProxy) {
        var screenWith = geo.size.width - horizontalPadding * 2 // padding on both sides
        
        if Dice.allCases.count > 1 {
            screenWith += spacing
        }
        
        // Calculate numberOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWith) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
    }
}

#Preview {
    ContentView()
}
