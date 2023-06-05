//
//  MainComponents.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 3/6/2023.
//
import Foundation
import SwiftUI

// CARDS
struct CardView: View {
    @Environment(\.colorScheme) var colorScheme
    let iconName: String?
    let sizeIcon: CGFloat?
    let title: String
    let titleIcon: String?
    let description: String
    let descriptionStats: String?
    let showChevron: Bool
    let clickDestination: AnyView?
    let sizeTitle: CGFloat?
    let sizeDesc: CGFloat?
    let cardColor: Color
    
    init(sizeIcon: CGFloat? = 0, iconName: String? = nil, title: String, titleIcon: String? = nil, description: String, descriptionStats: String? = nil, showChevron: Bool = false, clickDestination: AnyView? = nil, sizeTitle: CGFloat = 0, sizeDesc: CGFloat = 0, cardColor: Color) {
        self.iconName = iconName
        self.sizeIcon = sizeIcon
        self.title = title
        self.titleIcon = titleIcon
        self.description = description
        self.descriptionStats = descriptionStats
        self.showChevron = showChevron
        self.clickDestination = clickDestination
        self.sizeTitle = sizeTitle
        self.sizeDesc = sizeDesc
        self.cardColor = cardColor
    }
    
    var body: some View {
        if let destination = clickDestination {
            NavigationLink(destination: destination) {
                cardContent
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            cardContent
        }
    }
    
    @ViewBuilder
    var cardContent: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(cardColor)
                .shadow(color: Color.black.opacity(0.08), radius: 5)
                .overlay(
                    HStack {
                        if let iconName = iconName, geometry.size.width >= 300 && geometry.size.height >= 70 {
                            Image(systemName: iconName)
                                .font(.system(size: 30 + (sizeIcon ?? 0)))
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                if let iconName = iconName, geometry.size.width < 300 || geometry.size.height >= 130 {
                                    Image(systemName: iconName)
                                        .font(.system(size: 22))
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
                                        .padding(.trailing, 5)
                                }

                                Text(title)
                                    .font(.system(size: 18 + (sizeTitle ?? 0), weight: .semibold, design: .default))
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding(.bottom, 2)
                                                        
                                if let titleIcon = titleIcon {
                                    let components = titleIcon.split(separator: " ")
                                    if components.count >= 2 {
                                        let titleIconName = String(components[0])
                                        let titleColorName = String(components[1])

                                        if components.count == 3, let opacityValue = Double(components[2]) {
                                            let titleColor = getColor(colorName: titleColorName).opacity(opacityValue)
                                            Image(systemName: titleIconName)
                                                .font(.system(size: 20))
                                                .foregroundColor(titleColor)
                                                .alignmentGuide(.top, computeValue: { dimension in
                                                    dimension[.top]
                                                })
                                        } else {
                                            let titleColor = getColor(colorName: titleColorName)
                                            Image(systemName: titleIconName)
                                                .font(.system(size: 20))
                                                .foregroundColor(titleColor)
                                                .alignmentGuide(.top, computeValue: { dimension in
                                                    dimension[.top]
                                                })
                                        }
                                    }
                                }
                            }
                            
                            Text(description)
                                .font(.system(size: 14 + (sizeDesc ?? 0), weight: .regular, design: .default))
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.8))
                            
                            if let descriptionStats = descriptionStats {
                                Text(descriptionStats)
                                    .font(.system(size: 16 + (sizeDesc ?? 0), weight: .light, design: .default))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 0.9)))
                            }
                        }
                        .padding(.leading, geometry.size.width < 300 && geometry.size.height < 150 ? 0 : 8)
                        
                        if showChevron {
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 0.9)))
                        }
                    }
                    .padding()
                )
        }
    }
    
    func getColor(colorName: String) -> Color {
        switch colorName {
        case "green":
            return Color.green
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "mainColor":
            return Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
        default:
            return Color.black
        }
    }
}
