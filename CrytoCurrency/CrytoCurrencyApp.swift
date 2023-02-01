//
//  CrytoCurrencyApp.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/04.
//

import SwiftUI

@main
struct CrytoCurrencyApp: App {
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var launchScreenState = LaunchScreenStateManager()
    @State var showLaunchView: Bool = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle()) // iPad support
                .environmentObject(homeViewModel)
                
                ZStack {
                    if (showLaunchView) {
                        LaunchView(showLaunchScreen: $showLaunchView)
                            .transition(.move(edge: .leading))

                    }
                }
                .zIndex(2.0)
            }

            
            // Launch animation with image
            /*
             ZStack {
             NavigationView {
             HomeView()
             .navigationBarHidden(true)
             }
             if launchScreenState.state != .finished {
             LaunchScreenViewWithImage()
             }
             }
             .environmentObject(homeViewModel)
             .environmentObject(launchScreenState)
             */
        }
    }
}
