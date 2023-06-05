//
//  FactsView.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 3/6/2023.
//
import SwiftUI

struct FactView: View {
    @Environment(\.colorScheme) var colorScheme // Add this to access the current color scheme
    @State private var fact: String = ""
    @State private var showFact: Bool = false
    @State private var isPressed = false
    @State private var emoji: String = ""
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? UIColor.black : UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("💭 Did you know that..")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.top)
                    .padding(.bottom)
                if showFact {
                    Text(fact)
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.showFact = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.fact = FactView.getRandomFact()
                        self.emoji = FactView.getEmojiFromFact(self.fact) ?? ""
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.showFact = true
                        }
                    }
                }) {
                    Text("Generate")
                        .foregroundColor(.white)
                        .padding(.horizontal, 24) // Adjust horizontal padding
                        .padding(.vertical, 15) // Adjust vertical padding
                        .background(Color(red: 1, green: 0.4157, blue: 0.4314))
                        .cornerRadius(28)
                        .font(.system(size: 24, weight: .semibold,design: .default))
                        .shadow(color: Color(red: 1, green: 0.4157, blue: 0.4314).opacity(0.7), radius: 15)
                }
                .scaleEffect(isPressed ? 0.96 : 1.0)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut) {
                        self.isPressed = pressing
                    }
                }, perform: { })
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            self.fact = FactView.getRandomFact()
            self.emoji = FactView.getEmojiFromFact(self.fact) ?? ""
            self.showFact = true
        }
    }
    
    static func getRandomFact() -> String {
        guard let filePath = Bundle.main.path(forResource: "facts", ofType: "txt") else {
            return "Error while loading fact."
        }
        
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
            let facts = fileContents.components(separatedBy: .newlines)
            let randomIndex = Int.random(in: 0..<facts.count)
            return facts[randomIndex]
        } catch {
            print("Error reading file: \(error)")
            return "Error while loading fact."
        }
    }
    
    static func getEmojiFromFact(_ fact: String) -> String? {
        for scalar in fact.unicodeScalars {
            if scalar.properties.isEmoji {
                return String(scalar)
            }
        }
        return nil
    }
}



//struct EchoEffect: View {
//    let emoji: String?
//    @State private var echoAnimation = false
//
//    var body: some View {
//        if let emoji = emoji {
//            VStack {
//                ForEach(0..<10) { index in
//                    echoEmoji(delay: Double(index) * 0.2, offsetY: echoAnimation ? 700 : -50, scaleEffect: 0.2 + 0.08 * Double(index), opacity: 1 - 0.08 * Double(index))
//                        .padding(.horizontal, CGFloat(index) * 20)
//                }
//            }
//            .task {
//                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
//                    echoAnimation.toggle()
//                }
//                // Remove emojis after a delay
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    echoAnimation = false
//                }
//            }
//        } else {
//            EmptyView()
//        }
//    }
//
//    // Function to create an echo for emoji
//    func echoEmoji(delay: Double, offsetY: CGFloat, scaleEffect: CGFloat, opacity: Double) -> some View {
//        Text(emoji ?? "")
//            .font(.largeTitle)
//            .offset(y: offsetY)
//            .scaleEffect(scaleEffect)
//            .opacity(opacity)
//            .animation(Animation.easeInOut(duration: 2).delay(delay))
//    }
//}


struct FactView_Previews: PreviewProvider {
    static var previews: some View {
        FactView()
    }
}
