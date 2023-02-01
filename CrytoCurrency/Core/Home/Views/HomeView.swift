//
//  ContentView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/04.
//

import SwiftUI
import Combine
struct HomeView: View {
    @State var anyCancellable: AnyCancellable?
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var shouldShowLiveStatus: Bool = false
    @State private var shouldShowProtfolioView: Bool = false
    @State private var selectedCoin: CryptoModel? = nil
    @State private var shouldShowDetailView: Bool = false
    @State private var shouldSettingsView: Bool = false
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $shouldShowProtfolioView) {
                    PortfolioView()
                        .environmentObject(homeViewModel)
                }
            VStack(spacing: 20) {
                HStack {
                    homeHeader
                }
                HomeMarketStatsView(shouldShowHolding: $shouldShowLiveStatus)
                SearchBarView(searchText: $homeViewModel.searchText)
                columnTitles
                if (shouldShowLiveStatus) {
                    ZStack {
                        if (homeViewModel.portfolioCoins.isEmpty && homeViewModel.searchText.isEmpty) {
                            Text("Please add portfolio coins by clicking '+' button 💰")
                                .font(.title)
                        } else {
                            allholdingCoins
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                else {
                    allCoins
                        .transition(.move(edge: .leading))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $shouldSettingsView) {
                SettingsView()
            }
        }
        .background {
            NavigationLink(destination: CoinDetailView(coin: $selectedCoin), isActive: $shouldShowDetailView) {
                EmptyView()
            }
        }
        .onAppear {
            // MARK: - code for Launch animation with image
            // handleLaunchScreenAnimation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeViewModel)
        .environmentObject(LaunchScreenStateManager())
    }
}


extension HomeView {
    private var homeHeader: some View {
        Group {
            CircleButton(iconName: shouldShowLiveStatus ? "plus" : "info")
                .animation(.none, value: 0)
                .onTapGesture {
                    if (shouldShowLiveStatus) {
                        shouldShowProtfolioView.toggle()
                    } else {
                        shouldSettingsView.toggle()
                    }
                }
                .background(
                    AnimateCircleView(isAnimating: $shouldShowLiveStatus)
                )
            Spacer()
            Text(shouldShowLiveStatus ?  "Live Prices" : "Crypto" )
                .animation(.none)
                .foregroundColor(Color.theme.accent)
                .fontWeight(.heavy)
                .font(.headline)
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: shouldShowLiveStatus ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        shouldShowLiveStatus.toggle()
                    }
                }
        }
    }
    
    private var allCoins: some View {
        List {
            ForEach(homeViewModel.allCoins){ coin in
                CoinRowView(shouldShowHolding: $shouldShowLiveStatus, coinModel: coin)
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var allholdingCoins: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin  in
                CoinRowView(shouldShowHolding: $shouldShowLiveStatus, coinModel: coin)
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CryptoModel) {
        selectedCoin = coin
        shouldShowDetailView.toggle()
    }
    
    private var columnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.up")
                    .opacity(homeViewModel.sorting == .rank || homeViewModel.sorting == .rankReversed ? 1 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sorting == .rank ? 0 : 180), anchor: .center)
            }
            .onTapGesture {
                withAnimation {
                    homeViewModel.sorting =  homeViewModel.sorting == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if (shouldShowLiveStatus) {
                HStack {
                    Text("Holding")
                    Image(systemName: "chevron.up")
                        .opacity(homeViewModel.sorting == .holding || homeViewModel.sorting == .holdingReversed  ? 1 : 0.0)
                        .rotationEffect(Angle(degrees: homeViewModel.sorting == .holding ? 0 : 180), anchor: .center)
                }
                .onTapGesture {
                    withAnimation {
                        homeViewModel.sorting =  homeViewModel.sorting == .holding ? .holdingReversed : .holding
                    }
                }
                
            }
            Spacer()
            HStack {
                Text("Price")
                Image(systemName: "chevron.up")
                    .opacity(homeViewModel.sorting == .price || homeViewModel.sorting == .priceReversed  ? 1 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sorting == .price ? 0 : 180), anchor: .center)
                Button {
                    withAnimation(.linear(duration: 2.0)) {
                        homeViewModel.reloadData()
                    }
                } label: {
                    Image(systemName: "goforward")
                }
                .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0), anchor: .center)
            }
            .onTapGesture {
                withAnimation {
                    homeViewModel.sorting =  homeViewModel.sorting == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
    
    private func handleLaunchScreenAnimation() {
        anyCancellable = homeViewModel.$allCoins
            .sink { models in
                if !models.isEmpty {
                    if !homeViewModel.launchScreenCompleted {
                        launchScreenState.dismiss()
                    }
                }
            }
    }
}
