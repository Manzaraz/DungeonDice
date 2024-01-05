//
//  ButtonLayoutView.swift
//  DungeonDice
//
//  Created by Christian Manzaraz on 04/01/2024.
//

import SwiftUI

struct ButtonLayoutView: View {
    enum Dice: Int, CaseIterable {
        case four = 4, six = 6, eight = 8, ten = 10, twelve = 12, twenty = 20, hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    // A preference key struct wich we'll use to pass values up from child to parent View
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
        
    }
    
    @State private var buttonsLeftOver = 0 // # of buttons in a less-than-full row

    @Binding var resultMessage: String
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0 // Between buttons
    let buttonWidth: CGFloat = 105
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                    Button("\(dice.rawValue)-sided") {
                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                    }
                    .frame(width: buttonWidth)
                }
                
            }
            HStack(alignment: .center, content: {
                ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) {  dice in
                    Button("\(dice.rawValue)-sided") {
                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                    }
                    .frame(width: buttonWidth)
                }
            })
            
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .overlay {
            GeometryReader { geo in
                Color.clear
                    .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
            }
        }
        .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
            arrangeGridItems(deviceWidth: deviceWidth)
        }        
     
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
#Preview {
    ButtonLayoutView(resultMessage: .constant(""))
}
