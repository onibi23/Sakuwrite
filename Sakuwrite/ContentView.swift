//
//  ContentView.swift
//  Mostro
//
//  Created by Paola Barbuto Ferraiuolo on 11/12/24.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    private let motivationalPhrases = [
        "Believe in yourself and all that you are. Santo",
        "Act as if what you do makes a difference. It does.",
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        "Keep your face always toward the sunshine—and shadows will fall behind you.",
        "What lies behind us and what lies before us are tiny matters compared to what lies within us."
    ]

    @State private var randomPhrase: String = ""
    @State private var rotationAngle: Double = 0 // Track rotation
    @State private var dragOffset: CGSize = .zero // Track drag position
    @GestureState private var isDragging: Bool = false // Gesture state for dragging
    
    var body: some View {
        VStack {
            // Title
            Text("Today's Inspo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)

            Spacer()

            VStack {
                // Random motivational phrase
                Text(randomPhrase)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                // Image with rotation and drag gestures
                Image("FiorellinoROSA")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding()
                    .rotationEffect(.degrees(rotationAngle)) // Apply rotation
                    .offset(dragOffset) // Apply drag offset
                    .gesture(
                        DragGesture()
                            .updating($isDragging) { value, state, _ in
                                state = true
                                dragOffset = value.translation // Track drag position
                                rotationAngle = Double(value.translation.width) // Rotate based on drag width
                                
                                // Feedback during drag
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                            }
                            .onEnded { _ in
                                // Snap back to original position
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                    dragOffset = .zero
                                    rotationAngle = 0
                                }
                                
                                // Feedback when snapping back
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                            }
                    )
                    .onTapGesture {
                        // Spin animation
                        withAnimation(.easeInOut(duration: 1)) {
                            rotationAngle += 360
                        }
                        
                        // Feedback during spin
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            randomPhrase = motivationalPhrases.randomElement() ?? "Stay positive!"
        }
    }
}

#Preview {
    ContentView()
}
