//
//  VitalGuideApp.swift
//  VitalGuide
//
//  Created by Daoudi Rayane on 3/6/2023.
//
import SwiftUI
import HealthKit

class HealthDataAuthorizationStatus: ObservableObject {
    @Published var isAuthorized = false
    @Published var authorizationRequested = false
    static let preview = HealthDataAuthorizationStatus() // This is the static instance to use in previews
}

@main
struct VitalGuideApp: SwiftUI.App { // Update the struct declaration to conform to SwiftUI.App
    @StateObject var healthDataAuthorizationStatus = HealthDataAuthorizationStatus()
        
        @State var isPermissionGranted = false
    
    var body: some Scene { // Use 'some Scene' instead of 'some View' for the body type
        WindowGroup {
            Group {
                if healthDataAuthorizationStatus.isAuthorized || 1 == 1{
                    ContentView(healthDataAuthorizationStatus: healthDataAuthorizationStatus)
                } else {
                    // Show the ErrorHealthAuthorizationView
                    ErrorHealthAuthorizationView()
                }
            }
            .onAppear(perform: checkPermission)
        }
    }
    
    private func checkPermission() {
        isPermissionGranted = healthDataAuthorizationStatus.isAuthorized
    }
    
    private func checkHealthDataAuthorization() {
        let healthStore = HKHealthStore()
        let readDataTypes: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
        
        healthStore.requestAuthorization(toShare: [], read: readDataTypes) { (success, error) in
            DispatchQueue.main.async {
                healthDataAuthorizationStatus.isAuthorized = success
                healthDataAuthorizationStatus.authorizationRequested = true
            }
        }
    }
}
