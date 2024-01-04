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
    let buttonWidth: CGFloat = 120
    
    var body: some View {
        GeometryReader(content: { geo in
            VStack {
                
                titleView
                
                Spacer()
                
                resultMessageView
                
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
                arrangeGridItems(deviceWidth: geo.size.width)
            })
            .onAppear{
                arrangeGridItems(deviceWidth: geo.size.width)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        })
    }
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWith = deviceWidth - horizontalPadding * 2 // padding on both sides
        
        if Dice.allCases.count > 1 {
            screenWith += spacing
        }
        
        // Calculate numberOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWith) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
    }
}

extension ContentView {
    
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundStyle(.red)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.title)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
    
}

#Preview {
    ContentView()
}
