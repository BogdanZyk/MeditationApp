//
//  RootOnboardingView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct RootOnboardingView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @State private var isFirstOpenApp: Bool = true
    @State private var showLoginView: Bool = true
    var body: some View {
        ZStack{
            if showLoginView{
                LoginView()
                    .environmentObject(loginVM)
            }else {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $isFirstOpenApp) {
            OnboardingView()
        }
        .alert("", isPresented: $loginVM.showAlert) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(loginVM.error?.localizedDescription ?? "Unknow error")
        }
    }
}

struct RootOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        RootOnboardingView()
            .environmentObject(LoginViewModel())
    }
}
