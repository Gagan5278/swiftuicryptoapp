//
//  CircleButton.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/04.
//

import SwiftUI

struct CircleButton: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
              Circle()
                .foregroundColor(Color.theme.background)
            )
            .shadow(radius: 10)
            .padding()

    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButton(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }

    }
}
