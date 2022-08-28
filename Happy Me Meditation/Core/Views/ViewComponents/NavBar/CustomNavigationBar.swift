//
//  CustomNavigationBar.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct CustomNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 20){
            Button {
                dismiss()
            } label: {
                iconView("leftArrow", size: CGSize(width: 20, height: 20))
            }
            Spacer()
            Button {
                
            } label: {
                iconView("Favourites")
            }
            Button {
                
            } label: {
                iconView("Saved")
            }
            Button {
                
            } label: {
                iconView("share")
            }
            
        }
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
    }
}


extension CustomNavigationBar{
    private func iconView(_ icon: String, size: CGSize = CGSize(width: 25, height: 25)) -> some View{
        Image(icon)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0)
    }
}
