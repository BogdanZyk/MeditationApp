//
//  CalendarView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 05.09.2022.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var userManager: UserManagerViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 40) {
                    userHeaderSectionView
                    statSection
                    calendarSection
                    appSettingSection
                }
                .padding(.horizontal)
                .padding(.bottom, 120)
            }
        }
        .foregroundColor(.white)
        .background(Color.backgroung)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(LoginViewModel())
            .environmentObject(UserManagerViewModel())
    }
}


extension CalendarView{
    private var userHeaderSectionView: some View{
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("\(userManager.currentUser?.userName ?? "name")")
                    .font(.system(size: 28)).bold()
                Text("Here you can monitor statistics\nand check your progress")
                    .font(.urbRegular(size: 16))
            }
            Spacer()
            UserAvatarViewComponent(pathImage: userManager.currentUser?.profileImageUrl, size: CGSize.init(width: 86, height: 86))
        }
    }
    private var statSection: some View{
        VStack(spacing: 20) {
            TwigCarouselView()
            shareButton
        }
    }
    
    private var shareButton: some View{
        Button {
            
        } label: {
            Label {
                Image(systemName: "arrowshape.turn.up.right")
            } icon: {
                Text("Share my stats")
            }
            .font(.urbRegular(size: 18))
            .foregroundColor(.black)
            .hCenter()
            .frame(height: 44)
            .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10))
            
        }
    }
}


extension CalendarView{
    private var calendarSection: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("My Streaks")
                .font(.title2).bold()
            Text("Here we created statistics showing your sessions’ frequency. Be proud of your results")
                .font(.urbRegular(size: 18))
                CustomDatePickerView()
        }
    }
}


extension CalendarView{
    private var appSettingSection: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("App Settings")
                .font(.title2).bold()
            Text("All necessary information is here so you can manage it right in your app")
                .font(.urbRegular(size: 18))
            VStack(spacing: 0){
                ForEach(AppNavigationType.allCases, id: \.rawValue) { type in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack{
                            Image(type.rawValue)
                            Text(type.title)
                        }
                        .padding(.vertical, 10)
                         Divider().background(Color.emerald)
                        
                    }
                    .hLeading()
                }
                Button {
                    loginVM.logOut()
                } label: {
                    Label {
                        Text("Log out")
                    } icon: {
                        Image(systemName: "arrowshape.turn.up.left")
                    }
                    .foregroundColor(.orange.opacity(0.8))
                    .padding(.vertical, 10)
                    .hLeading()
                }

            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.darkEmerald, in: RoundedRectangle(cornerRadius: 20))
        }
    }
    
}


enum AppNavigationType: String, CaseIterable {
    case account = "account"
    case fullAccess = "diamond"
    case reminders = "bell"
    case invite = "invite"
    case followUs = "follow"
    case contactUs = "contactUs"
    
    var title: String{
        switch self {
        case .account:
            return "Account"
        case .fullAccess:
            return "Get full access"
        case .reminders:
            return "Reminders"
        case .invite:
            return "Invite Friends"
        case .followUs:
            return "Follow us"
        case .contactUs:
            return "Contact us"
        }
    }
}
