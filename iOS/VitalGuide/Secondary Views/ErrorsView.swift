//
//  ErrorsView.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 4/6/2023.
//
import Foundation
import SwiftUI
import HealthKit

struct ErrorHealthAuthorizationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let backgroundColor = colorScheme == .dark ? Color.black : Color.white
        let textColor = colorScheme == .dark ? Color.white : Color.black
        let highlightColor = Color(#colorLiteral(red: 1, green: 0.4157, blue: 0.4314, alpha: 1))
        let secondaryColor = colorScheme == .dark ? Color.white : Color.black.opacity(0.6)
        
        VStack {
            Spacer()
            
            Image("unknown_illustration")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()

            Text("We need your authorization")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("To provide you with health data, we need your authorization. Please click on the button below to provide access.")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .padding()

            Button("Give app authorization") {
                requestHealthKitAuthorization()
            }
            .font(.system(.callout, weight: .semibold))
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(highlightColor)
            .cornerRadius(16)
            .padding(.horizontal)
            
            Button("How to give authorization") {
                // Handle button action here to show tutorial
            }
            .font(.system(.callout, weight: .semibold))
            .padding()
            .foregroundColor(highlightColor)

            Spacer()
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        .foregroundColor(textColor)
    }
    
    private func requestHealthKitAuthorization() {
        let healthStore = HKHealthStore()
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!]) // Replace .heartRate with your desired quantity types
        
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            // Handle authorization response here
        }
    }
}

struct Errors_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorHealthAuthorizationView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            ErrorHealthAuthorizationView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}


