//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by ramsayleung on 2024-04-01.
//

import SwiftUI

struct ContentView: View {
    let colors : [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
                GeometryReader { fullView in
                    ScrollView {
                        ForEach(0..<50) { index in
                            GeometryReader { proxy in
                                Text("Row #\(index)")
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hue: calculateHue(y: proxy.frame(in: .global).minY, containerHeight: fullView.size.height), saturation: 1, brightness: 1))
                                    .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                    .opacity(proxy.frame(in: .global).minY/(fullView.size.height / 2))
                                    .scaleEffect(calculateScaleEffect(y: proxy.frame(in: .global).minY, containerHeight: fullView.size.height))
                            }
                            .frame(height: 40)
                        }
                    }
                }
    }
    
    // Make views adjust their scale depending on their vertical position, with views near the bottom being large and views near the top being small.
    // no smaller than 50% of the regular size.
    func calculateScaleEffect(y coordinateY: Double, containerHeight: Double) -> Double {
        let midHeight = containerHeight / 1.5
        return 0.5 + 0.5 * (coordinateY / midHeight)
    }
    
    func calculateHue(y coordinateY: Double, containerHeight: Double) -> Double {
        return 1 - coordinateY / containerHeight
    }
}

#Preview {
    ContentView()
}
