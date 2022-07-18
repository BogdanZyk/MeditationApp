//
//  LoginView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI


struct LoginView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @State private var isLoginView: Bool = false
    @FocusState private var isFocused: FocusField?
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var body: some View {
        ZStack(alignment: .bottom){
            Color.backgroung
            bgImage
            VStack(spacing: 30) {
                logoView
                if isLoginView{
                    signInSection
                }else{
                    signUpSection
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, safeAreaInsets.top)
        }
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 13")
            .environmentObject(LoginViewModel())
            .preferredColorScheme(.dark)
    }
}

extension LoginView {
    
    
    private var bgImage: some View{
        Image("bgImage")
            .resizable()
            .scaledToFit()
            .clipped()
    }
    
    private var logoView: some View{
        Image("logoLogin")
            .resizable()
            .scaledToFit()
            .padding(.bottom, 10)
    }
    
    
    private var signInSection: some View{
        Group{
            inputSectionView
            socialsectionView
            bottomSectionButton
        }
        .transition(.asymmetric(insertion: .slide, removal: .opacity))
    }
    
    private var signUpSection: some View{
        Group{
            inputSectionView
            socialsectionView
            bottomSectionButton
        }
        .transition(.asymmetric(insertion: .slide, removal: .opacity))
    }
    
    
    private var bottomSectionButton: some View{
        HStack{
            Text(isLoginView ? "Don’t have an account?" : "Already have an account?")
            Button {
                withAnimation(.easeOut(duration: 0.2)) {
                    isLoginView.toggle()
                }
            } label: {
                Text(isLoginView ? "Sign up" : "Sign in")
                    .foregroundColor(.accentOrange)
            }
        }
        .foregroundColor(.white)
        .font(.urbMedium(size: 18))
        .animation(nil, value: UUID().uuidString)
    }
    
    private var socialsectionView: some View{
        VStack(spacing: 30) {
            HStack(spacing: 20){
                VStack {
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.6))
                }
                Text("or")
                    .foregroundColor(.white)
                    .font(.urbMedium(size: 20))
                VStack {
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.6))
                }
            }
            socualSection
        }
    }
    private var inputSectionView: some View{
        VStack(spacing: 20) {
            CustomTextField(text: $loginVM.email, promt: "Email", isSecureTF: false, isFocused: isFocused == .email)
                .focused($isFocused, equals: .email)
            CustomTextField(text: $loginVM.password, promt: "Password", isSecureTF: true, isFocused: isFocused == .pass)
                .focused($isFocused, equals: .pass)
            if loginVM.isLoading{
                ProgressLoader(color: .accentOrange, scaleEffect: 1.5)
                    .frame(height: 50)
            }else{
                CustomButton(title: isLoginView ? "Sign In" : "Sign Up", isDisabled: !loginVM.isValidLoginForms) {
                    if isLoginView{
                        loginVM.logIn()
                    }else{
                        loginVM.createAccount()
                    }
                }
                .animation(nil, value: UUID().uuidString)
            }
        }
    }
    

    
    private var socualSection: some View{
        VStack(spacing: 20) {
            socialButton()
            socialButton(isApple: true)
        }
    }
    
    
    private func socialButton(isApple: Bool = false) -> some View{
        Button {
            
        } label: {
            HStack{
                Label {
                    Text("Continue with \(isApple ? "Apple" : "Facebook")")
                } icon: {
                  if isApple {
                     Image(systemName: "applelogo")
                          .font(.system(size: 23))
                  }else{
                      Image("Facebook")
                          
                  }
                }
                .font(.urbMedium(size: 18))
                .foregroundColor(.white)
                .hCenter()
                .frame(height: 50)
                .background(Color.emerald.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}


enum FocusField{
    case email
    case pass
}
