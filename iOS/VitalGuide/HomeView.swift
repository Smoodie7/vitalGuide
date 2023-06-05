//
//  HomeView.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 4/6/2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var isFactViewShown = false

    private var backgroundColor: Color {
            colorScheme == .dark ? .black : Color(red: 0.953, green: 0.953, blue: 0.953)
        }
        
        private var cardColor: Color {
            colorScheme == .dark ? Color(red: 25/255, green: 25/255, blue: 25/255) : .white
        }
    
    private let cardSize: CGFloat = 160
    private let smallCardSize: CGFloat = 140
    private let largeCardSize: CGFloat = 220
    private let sectionTitleFont = Font.system(size: 36, weight: .bold, design: .default)
    private let mainColor = Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {  // Add spacing parameter here
                        greetingView.padding(.top)
                        adviceCardView.padding(.top)
                        healthTitleView.padding(.vertical, 30)
                        noiseLevelCardView.padding(.vertical, 5)
                        healthCardScrollView.padding(.vertical)
                        articlesTitleView.padding(.vertical)
                        articlesContentView
                    }
                    .padding(.horizontal)
                    .accentColor(mainColor)
                }
                .modifier(NavigationViewBackground(color: backgroundColor))
            }
            .accentColor(mainColor)  
        }
    
    private var greetingView: some View {
        Text("Hello, Arthur \(getDaytimeEmoji())")
            .font(.system(size: 30))	
    }
    
    private var adviceCardView: some View {
        HStack(spacing: 18.0) {
            CardView(title: "Need advice?", description: "Talk with your virtual doctors.", showChevron:true, cardColor: cardColor)
                .frame(width: 160, height: 120)
            CardView(title: "Feel like learning?", description: "Explore random facts here!", showChevron:true, clickDestination: AnyView(FactView()), cardColor: cardColor)
                .frame(width: 175, height: 120)
        }
    }
    
    private var healthTitleView: some View {
        HStack(alignment: .center) {
            Text("Your health.")
                .font(sectionTitleFont)
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 25))
                .foregroundColor(mainColor.opacity(0.8))
        }
    }
    
    private var noiseLevelCardView: some View {
        CardView(sizeIcon: 10, iconName: "ear", title: "Noise levels", titleIcon: "checkmark.circle.fill mainColor 0.8", description: "Every thing looks okay.", showChevron: true, cardColor: cardColor)
            .frame(width: 350, height: 70)
    }
    
    private var healthCardScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14.0) {
                // Card: Sleep
                CardView(sizeIcon: 10, iconName: "powersleep", title: "Sleep", titleIcon: "checkmark.circle.fill mainColor 0.8", description: "Your sleep schedule looks fine.", showChevron: true, cardColor: cardColor)
                    .frame(width: 200, height: 120)
                
                // Card: Activities
                CardView(sizeIcon: 10, iconName: "flame", title: "Activities", titleIcon: "checkmark.circle.fill mainColor 0.8", description: "You seem to be in great shape.", showChevron: true, cardColor: cardColor)
                    .frame(width: 200, height: 120)
                
                // Card: Activities (Duplicate)
                CardView(sizeIcon: 10, iconName: "flame", title: "Activities", titleIcon: "checkmark.circle.fill mainColor 0.8", description: "You seem to be in great shape.", showChevron: true, cardColor: cardColor)
                    .frame(width: 200, height: 120)
            }
        }
    }
    
    private var articlesTitleView: some View {
        Text("Articles.")
            .font(sectionTitleFont)
    }
    
    private var articlesContentView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(1...3, id: \.self) { _ in
                    ArticlesContentItemView()
                }
            }
        }
    }

    struct ArticlesContentItemView: View {
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            VStack(alignment: .leading) {
                VStack(spacing: 0) {
                    Image("placeholder-16:9")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220, height: 120)
                        .clipShape(TopRoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, -10)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lorem Ipsum Loremi Faso Long Mio")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: 220)
                    
                    HStack(spacing: 20) {
                        Text("\(Int.random(in: 1...7)) days ago")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("-")
                            .foregroundColor(.secondary)
                        
                        Text("\(Int.random(in: 1...60)) min.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: 220)
                }
                .padding(.vertical, 8)
                
            }
            .padding(.horizontal, 12)
            .frame(width: 220) // Adjust the width as per your requirement
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .dark ? Color.black : .white) // Use the color scheme to set the background color
                    .shadow(color: Color.black.opacity(0.08), radius: 5)
            )
        }
    }



    private func getDaytimeEmoji() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        return (hour >= 9 && hour < 18) ? "☀️" : "🌙"
    }
    
    // Utils
    struct TopRoundedRectangle: Shape {
        let cornerRadius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius), control: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            return path
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            HomeView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
