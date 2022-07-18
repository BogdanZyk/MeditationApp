//
//  MainView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        VStack {
            Text("MainView")
            Button {
                loginVM.logOut()
            } label: {
                Text("logOut")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(LoginViewModel())
    }
}
