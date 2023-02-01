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
            /*
             Either Section 1 OR Section 2 should open for app launch.
             */
          // Section 1.  With Animated text splash screen
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

            
            // Section 2.  Launch animation with image
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
