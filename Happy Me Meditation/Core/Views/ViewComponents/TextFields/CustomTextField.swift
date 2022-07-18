//
//  CustomTextField.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var promt: String = "Text here"
    var font: Font = .urbRegular(size: 18)
    var height: CGFloat = 56
    var cornerRadius: CGFloat = 10
    var isSecureTF: Bool = false
    var isFocused: Bool = false
    @State private var showPass: Bool = false
    var body: some View {
        HStack{
            dinamicTextFieldView(showPass)
            Spacer()
            if isSecureTF{
                eyeButton
            }
        }
        .foregroundColor(.fontSecondary)
        .padding(.horizontal, 20)
        .frame(height: height)
        .hLeading()
        .background(isFocused ? Color.clear : Color.emerald.opacity(text.isEmpty ? 0.2 : 1))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay{
            if isFocused{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.emerald, lineWidth: 1.5)
            }
        }
        .font(font)
        .onAppear {
            showPass = isSecureTF
        }
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroung
            CustomTextField(text: .constant(""))
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}

extension CustomTextField{
    
    private func dinamicTextFieldView(_ isSecure: Bool) -> some View{
        Group{
          if isSecure {
                SecureField(text: $text) {
                    Text(promt)
                        
                }
            }else{
                TextField(text: $text) {
                    Text(promt)
                }
            }
        }
    }
    private var eyeButton: some View{
        Button {
            showPass.toggle()
        } label: {
            Image(systemName: showPass ? "eye.fill" : "eye.slash.fill")
                .font(.callout)
                .foregroundColor(.fontSecondary)
        }
    }
}
