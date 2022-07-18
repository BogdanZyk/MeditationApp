//
//  CustomButton.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    var height: CGFloat = 50
    var fontSize: Int = 18
    var isDisabled: Bool = false
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.urbMedium(size: fontSize))
                .foregroundColor(.backgroung)
                .hCenter()
                .frame(height: height)
                .background(Color.accentOrange, in: RoundedRectangle(cornerRadius: 10))
        }
        .opacity(isDisabled ? 0.5 : 1)
        .disabled(isDisabled)
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "test", action: {})
            .padding()
    }
}
