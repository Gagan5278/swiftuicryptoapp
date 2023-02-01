//
//  SettingsView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/02/01.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    // MARK: - Don't use force wrapping in Production app
    private let appleSwiftUIURL = URL(string: "https://developer.apple.com/tutorials/swiftui")!
    private let swiftUIYouTubeLink  = URL(string: "https://www.youtube.com/results?search_query=swiftui")!
    private let coinGekoAPILink = URL(string: "https://www.coingecko.com/en/api")!
    private let developerLinkedPageLink = URL(string: "https://www.linkedin.com/in/gagan-vishal-mishra-a4268921/")!
    private let developerLinkTreePageLink = URL(string: "https://linktr.ee/gagan.vishal.mishra")!
    private let developerGithubPageLink = URL(string: "https://github.com/Gagan5278")!
    
    var body: some View {
        NavigationView {
            List {
                swiftUILearningSection
                swiftUILearningCoinGeko
                swiftUILearningDeveloperIntro
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement:  .navigationBarLeading) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    private var swiftUILearningSection: some View {
        Section(header: Text("Swift UI Learning"),content: {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made for learning SwiftUI. Uses MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            Link("Apple Swift UI", destination: appleSwiftUIURL)
                .foregroundColor(.blue)
                .font(.callout)
            Link("Swift UI Youtube", destination: swiftUIYouTubeLink)
                .foregroundColor(.blue)
                .font(.callout)
            
        })
    }
    
    private var swiftUILearningCoinGeko: some View {
        Section(header: Text("CoinGeko API used"),content: {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app uses CoinGeko api for real time data for all coins. Use of api is free of charge.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            Link("CoinGeko API", destination: coinGekoAPILink)
                .foregroundColor(.blue)
                .font(.callout)
        })
    }
    
    private var swiftUILearningDeveloperIntro: some View {
        Section(header: Text("Developer Intro"),content: {
            VStack(alignment: .leading) {
                Image("developer")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Gagan Vishal and is written in 100% SwiftUI. App uses Multi-threading, publisher/subscriber and coredata for data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
            }
            Link("LinkedIn link", destination: developerLinkedPageLink)
                .foregroundColor(.blue)
                .font(.callout)
            Link("GitHub link", destination: developerGithubPageLink)
                .foregroundColor(.blue)
                .font(.callout)
            Link("LinkTr.ee Link", destination: developerLinkTreePageLink)
                .foregroundColor(.blue)
                .font(.callout)
        })
    }
}
