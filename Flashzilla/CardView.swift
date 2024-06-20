//
//  CardView.swift
//  Flashzilla
//
//  Created by Kenneth Oliver Rathbun on 6/7/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    var removal: ((Bool) -> Void)? = nil
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                        ? .white
                        : .white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .cardBackground(offset: offset, differentiateWithoutColor: accessibilityDifferentiateWithoutColor)
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .draggable(offset: $offset, removal: removal)

        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

struct BackgroundColorModifier: ViewModifier {
    var offset: CGSize
    var differentiateWithoutColor: Bool
    var color: Color {
        if offset.width == 0 {
            return .clear
        } else if offset.width > 0 {
            return .green
        } else {
            return .red
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                differentiateWithoutColor 
                ? nil
                : RoundedRectangle(cornerRadius: 25.0)
                    .fill(color)
            )
    }
}

extension View {
    func cardBackground(offset: CGSize, differentiateWithoutColor: Bool) -> some View {
        self.modifier(BackgroundColorModifier(offset: offset, differentiateWithoutColor: differentiateWithoutColor))
    }
}

#Preview {
    CardView(card: Card.example)
}
