//
//  ContentView.swift
//  Orbiter
//
//  Created by Mostafa Abdellateef on 11/11/21.
//

import SwiftUI
import Combine

private let orbitLength: Double = 380
private let fullCircleDuration: Double = 4.5

struct ContentView: View {
    @State private var startAnimation: Bool = false
    @StateObject private var flipFlop = FlipFlop(interval: fullCircleDuration / 2)
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Stars(availableSize: proxy.size)
            }
            Text("🌕")
                .font(.system(size: 120))
                .overlay(
                    Circle()
                        .padding(EdgeInsets(top: 5, leading: 4, bottom: 4, trailing: 6))
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                        .opacity(flipFlop.value ? 0 : 0.6)
                        .animation(.easeInOut(duration: fullCircleDuration / 2))
                )
                .zIndex(flipFlop.value ? 0 : 1)
            
            Text("🪐")
                .rotationEffect(Angle.degrees(110))
                .font(.system(size: 40))
                .foregroundColor(.yellow)
                .offset(
                    x: startAnimation ? 1: 0,
                    y: startAnimation ? -0.3 : 0
                )
        }
        .animation(.orbitAnimation.repeatForever(autoreverses: false), value: startAnimation)
        .ignoresSafeArea()
        .onAppear {
            startAnimation.toggle()
        }
    }
}

/// Toggle and publish a Boolean value at a given frequency
private class FlipFlop: ObservableObject {
    @Published var value: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init(interval: TimeInterval) {
        Timer.publish(every: interval, on: .current, in: .default)
            .autoconnect()
            .delay(for: .seconds(1), scheduler: RunLoop.main, options: .none)
            .sink(receiveValue: { [weak self] _ in
                self?.value.toggle()
            })
            .store(in: &cancellables)
    }
}

private extension Animation {
    static var orbitAnimation : Animation {
        .timingCurve(0.333, -orbitLength, 0.666, orbitLength, duration: fullCircleDuration)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
