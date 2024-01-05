//
//  ContentView.swift
//  DungeonDice
//
//  Created by Christian Manzaraz on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var resultMessage = ""
    
    var body: some View {
        VStack {
            
            titleView
            
            Spacer()
            
            resultMessageView
            
            Spacer()
            
            ButtonLayoutView(resultMessage: $resultMessage)
        
        }
        .padding()
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
