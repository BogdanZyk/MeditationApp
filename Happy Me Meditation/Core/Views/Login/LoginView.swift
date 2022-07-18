//
//  LoginView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        VStack(spacing: 15){
            Text(loginVM.isloggedUser.description)
            TextField("name", text: $loginVM.userName)
                .padding()
                .background(Color.gray.opacity(0.12))
            TextField("email", text: $loginVM.email)
                .padding()
                .background(Color.gray.opacity(0.12))
            TextField("password", text: $loginVM.password)
                .padding()
                .background(Color.gray.opacity(0.12))
            Button {
                loginVM.createAccount()
            } label: {
                Text("Create account")
                    //.font(.urbMedium(size: 20))
                    .font(.fjallaOne(size: 20))
            }

        }
        .padding(.horizontal)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
