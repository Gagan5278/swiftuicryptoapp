//
//  LaunchView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/02/01.
//

import SwiftUI

struct LaunchView: View {
    @State var loadingText: [String] = "Loading data...".map{ String($0) }
    @State var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchScreen: Bool
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                ZStack {
                    if showLoadingText {
                        HStack(spacing: 0) {
                            ForEach(loadingText.indices, id: \.self) { index in
                                Text(loadingText[index])
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.theme.accent)
                                    .offset(y: index ==  counter ? 5 : 0)
                            }
                        }
                        .transition(AnyTransition.scale.animation(.easeIn))
                    }
                }
            }
            .padding()
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops > 3 {
                        showLaunchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchScreen: .constant(false))
    }
}
