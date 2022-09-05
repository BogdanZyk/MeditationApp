//
//  CalendarView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 05.09.2022.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        Button {
            loginVM.logOut()
        } label: {
            Text("logout")
        }

    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(LoginViewModel())
    }
}
