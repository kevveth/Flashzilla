//
//  ContentView.swift
//  Flashzilla
//
//  Created by Kenneth Oliver Rathbun on 6/5/24.
//

import SwiftUI

struct Card {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "What is the name of Goku's Grandfather?", answer: "Gohan")
}

struct ContentView: View {
    
    
    var body: some View {
        Text("")
    }
}

#Preview {
    ContentView()
}
