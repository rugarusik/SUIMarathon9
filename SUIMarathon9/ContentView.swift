//
//  ContentView.swift
//  SUIMarathon9
//
//  Created by Alina Golubeva on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    private let diameter: CGFloat = 150
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Canvas { context, size in
                    let circle1 = context.resolveSymbol(id: "first")!
                    let circle2 = context.resolveSymbol(id: "second")!
                    
                    context.addFilter (.alphaThreshold (min: 0.7, color: .blue))
                    context.addFilter (.blur (radius: 20))
                    
                    context.drawLayer { ctx in
                        ctx.draw(circle1, at: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        ctx.draw(circle2, at: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    }
                } symbols: {
                    Circle()
                        .frame(width: diameter, height: diameter, alignment: .center)
                        .tag("first")
                    Circle()
                        .frame(width: diameter, height: diameter, alignment: .center)
                        .tag("second")
                        .offset(offset)
                }
            }
            .gesture(
                DragGesture().onChanged { value in
                    offset = value.translation
                }.onEnded { _ in
                    withAnimation(.spring(bounce: 0.3)) {
                        offset = .zero
                    }
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
