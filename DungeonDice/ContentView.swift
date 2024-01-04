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
    
    
    var body: some View {
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
            
            
            ForEach(Dice.allCases, id: \.self) { dice in
                Button("\(dice.rawValue)-sided") {
                    resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                }
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .tint(.red)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
