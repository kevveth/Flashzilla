//
//  DraggableModifier.swift
//  Flashzilla
//
//  Created by Kenneth Oliver Rathbun on 6/18/24.
//

import SwiftUI

struct DraggableModifier: ViewModifier {
    @Binding var offset: CGSize
    var removal: ((Bool) -> Void)?

    func body(content: Content) -> some View {
        content
            .offset(x: offset.width * 5)
            .rotationEffect(.degrees(offset.width / 5))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            offset.width > 0 ? removal?(true) : removal?(false)
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}

extension View {
    func draggable(offset: Binding<CGSize>, removal: ((Bool) -> Void)? = nil) -> some View {
        self.modifier(DraggableModifier(offset: offset, removal: removal))
    }
}
