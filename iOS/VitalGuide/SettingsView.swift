//
//  SettingsView.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 3/6/2023.
//
import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let mainColor = Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("General")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(textColor)
                            .padding(.vertical, 5)
                        
                        SettingRow(iconName: "person.crop.circle", title: "Account", destination: AccountSettingsView())
                        SettingRow(iconName: "bell", title: "Notifications", destination: NotificationSettingsView())
                        
                        Text("Privacy")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(textColor)
                            .padding(.vertical, 5)
                        
                        SettingRow(iconName: "lock.shield", title: "Privacy Settings", destination: PrivacySettingsView())
                        SettingRow(iconName: "person.crop.circle", title: "Profile", destination: ProfileSettingsView())
                        
                        Spacer()
                        
                        Button(action: {
                            // Handle sign out action
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .background(mainColor.opacity(0.1))
                                .cornerRadius(15)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Settings ⚙️")
                    .navigationBarTitleDisplayMode(.large)
                    .accentColor(.white)
                }
            }
            .accentColor(mainColor)
        }
        .accentColor(mainColor)  
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : Color(red: 0.953, green: 0.953, blue: 0.953)
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    struct SettingRow<Destination: View>: View {
        let iconName: String
        let title: String
        let destination: Destination
        let mainColor = Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
        
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            NavigationLink(destination: destination) {
                HStack {
                    Image(systemName: iconName)
                        .font(.system(size: 20))
                        .frame(width: 30, height: 30)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(foregroundColor)
                    
                    Text(title)
                        .font(.system(size: 16))
                        .foregroundColor(foregroundColor)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(mainColor.opacity(0.8))
                        .font(.system(size: 16))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(backgroundColor)
                .cornerRadius(15)
                .shadow(color: shadowColor, radius: 5)
            }
        }
        
        private var foregroundColor: Color {
            colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.8)
        }
        
        private var backgroundColor: Color {
            colorScheme == .dark ? Color.gray.opacity(0.1) : .white
        }
        
        private var shadowColor: Color {
            Color.black.opacity(0.08)
        }
    }
    
    struct AccountSettingsView: View {
        var body: some View {
            Text("Account Settings")
        }
    }
    
    struct NotificationSettingsView: View {
        var body: some View {
            Text("Notification Settings")
        }
    }
    
    struct PrivacySettingsView: View {
        var body: some View {
            Text("Privacy Settings")
        }
    }
    
    struct ProfileSettingsView: View {
        var body: some View {
            Text("Profile Settings")
        }
    }
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                SettingsView()
                    .preferredColorScheme(.light)
                    .previewDisplayName("Light Mode")
                
                SettingsView()
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark Mode")
            }
        }
    }
}

