//
//  AnimateCircleView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/04.
//

import SwiftUI

struct AnimateCircleView: View {
    @Binding var isAnimating: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth:isAnimating ? 5 : 0)
            .scale(isAnimating ? 1 :0)
            .opacity(isAnimating ? 0 : 1 )
            .animation(isAnimating ? Animation.easeOut(duration: 5) : .none, value: 0)

    }
}

struct AnimateCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AnimateCircleView(isAnimating: .constant(false))
    }
}
