//
//  PortfolioView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/23.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeViewModel:HomeViewModel
    @State var selectedCoin: CryptoModel?
    @State private var quantityText = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    coinListView
                    if selectedCoin != nil {
                        HStack {
                            Text("Current prfice for:\(selectedCoin!.name)")
                            Spacer()
                            Text("\(selectedCoin!.currentPrice.asTwoDigitNumberString)")
                        }
                        .padding()
                        Divider()
                        HStack {
                            Text("Amount in your portfolio:")
                            Spacer()
                            TextField("Ex 1.4", text: $quantityText)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        Divider()
                        HStack {
                            Text("Current value:")
                            Spacer()
                            Text(convertIntoDouble().asTwoDigitNumberString)
                                .multilineTextAlignment(.trailing)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Portfolio")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeViewModel)
    }
}


extension PortfolioView {
    var coinListView: some View {
        Group {
            SearchBarView(searchText: $homeViewModel.searchText)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    ForEach(homeViewModel.searchText.isEmpty ? homeViewModel.portfolioCoins :  homeViewModel.allCoins) { coin in
                        PortfolioCoinView(coinModel: coin)
                            .onTapGesture {
                                update(coin: coin)
                            }
                            .frame(width: 50)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear , lineWidth: 2)
                            )
                    }
                }
                .padding(.leading, 10)
                .padding()
            }
        }
    }
    
    private func update(coin: CryptoModel) {
        selectedCoin = coin
        if let portfolioCoin = homeViewModel.portfolioCoins.first(where: { $0.id == coin.id }) {
            if let amount = portfolioCoin.currentHolding {
                quantityText = "\(amount)"
            } else {
                quantityText = ""
            }
        }
    }
    
    private func convertIntoDouble() -> Double {
        ( Double(quantityText) ?? 0.0 ) * selectedCoin!.currentPrice
    }
    
    var saveButton: some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark")
            Button(action: {
                saveButtonAction()
            }, label: {
                Text("SAVE")
                    .font(.headline)
            })
        }
        .opacity(quantityText.isEmpty ? 0.0 : 1.0)
    }
    
    
    private func saveButtonAction() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
              else { return }
        homeViewModel.updatePortfolio(coin: coin, amount: amount)
        withAnimation {
            selectedCoin = nil
            homeViewModel.searchText = ""
        }
        //Hide Keyboard
        UIApplication.shared.endEditing()
    }
}
