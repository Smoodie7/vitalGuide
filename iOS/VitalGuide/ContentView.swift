//
//  ContentView.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 3/6/2023.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var healthDataAuthorizationStatus: HealthDataAuthorizationStatus

    @Environment(\.colorScheme) var colorScheme
    @State var selectedTab = "house.fill"
    @State var showWelcomeScreen = true
    @State var temp = true
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : Color(red: 0.953, green: 0.953, blue: 0.953)
    }
    
    private var tabBarColor: Color {
        colorScheme == .dark ? Color(red: 25/255, green: 25/255, blue: 25/255) : .white
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top empty bar to avoid clipping with iOS elements
                if hasNotch {
                    backgroundColor
                        .frame(height: 52)
                }
                
                switch selectedTab {
                case "house.fill":
                    HomeView()
                case "message.fill":
                    HomeView()
                case "person.fill":
                    SettingsView()
                case "gearshape.fill":
                    SettingsView()
                default:
                    Text("Selection does not match any tab.")
                }
                
                Spacer() // Content of your View goes here
                
                TabBar(selectedTab: $selectedTab, tabBarColor: tabBarColor)
            }
            .sheet(isPresented: $showWelcomeScreen, content: WelcomeView.init)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    private var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}


struct NavigationViewBackground: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            color.edgesIgnoringSafeArea(.all)
            content
        }
    }
}

struct TabBar: View {
    @Binding var selectedTab: String
    let tabBarColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    TabBarButton(imageName: "house", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(imageName: "message", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(imageName: "person", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                    TabBarButton(imageName: "gearshape", selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 10)
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .background(tabBarColor)
                .edgesIgnoringSafeArea(.bottom)
            }
        }.frame(height: 80)
    }
}


struct TabBarButton: View {
    let imageName: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = imageName + ".fill"
        }) {
            tabBarButtonContent()
        }
    }
    
    private func tabBarButtonContent() -> some View {
        Image(systemName: selectedTab == imageName + ".fill" ? imageName + ".fill" : imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 27, height: 27)
            .padding(15)
            .background(selectedTab == imageName + ".fill" ? Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 0.8)) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 23))
            .foregroundColor(selectedTab == imageName + ".fill" ? .white : .gray)
    }
}



// WELCOME POPUP
struct WelcomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let backgroundColor = colorScheme == .dark ? Color.black : Color.white
        let textColor = colorScheme == .dark ? Color.white : Color.black
        let highlightColor = Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
        let secondaryColor = colorScheme == .dark ? Color.white : Color.black.opacity(0.6)
        
        VStack {
            Text("Welcome to VitalGuide.")
                .font(.system(.largeTitle, weight: .bold))
                .foregroundColor(textColor)
                .frame(width: 240)
                .multilineTextAlignment(.center)
                .padding(.top, 82)
                .padding(.bottom, 52)
            
            VStack(spacing: 28) {
                let features = [
                    ("Personalized Health Guidance", "With our virtual doctor, receive tailored advice and answers to your health questions anytime, anywhere.", "person.crop.circle"),
                    ("Learn as You Go", "Delve into our wide collection of engaging health facts and articles to broaden your knowledge and understand your health better.", "book"),
                    ("And more..", "Customize your experience and settings to make your health journey truly your own.", "slider.horizontal.3")
                ]
                
                ForEach(features, id: \.0) { feature in
                    HStack {
                        Image(systemName: feature.2)
                            .foregroundColor(highlightColor)
                            .font(.system(.title, weight: .regular))
                            .frame(width: 60, height: 50)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(feature.0)
                                .font(.system(.footnote, weight: .semibold))
                                .foregroundColor(textColor)
                            
                            Text(feature.1)
                                .font(.footnote)
                                .foregroundColor(secondaryColor)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                }
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text("Complete feature list")
                    .foregroundColor(highlightColor)
                
                Image(systemName: "chevron.forward")
                    .imageScale(.small)
                    .foregroundColor(highlightColor)
            }
            .padding(.top, 32)
            .font(.subheadline)
            
            Spacer()
            
            Button("Continue") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .font(.system(.callout, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(highlightColor)
            .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 53)
        .padding(.horizontal, 29)
        .background(backgroundColor)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(healthDataAuthorizationStatus: HealthDataAuthorizationStatus.preview)
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            ContentView(healthDataAuthorizationStatus: HealthDataAuthorizationStatus.preview)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
