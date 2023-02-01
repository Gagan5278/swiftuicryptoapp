//
//  XMarkButton.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/23.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
           dismiss()
    }, label: {
           Image(systemName: "xmark")
              .font(.headline)
    })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
