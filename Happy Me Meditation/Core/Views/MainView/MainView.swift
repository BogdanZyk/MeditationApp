//
//  MainView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainVM = MainViewModel()
    @StateObject var userManager = UserManagerViewModel()
    @EnvironmentObject var loginVM: LoginViewModel
    init(){
    
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $mainVM.currentTab) {
                    HomeView()
                        .tag(Tab.home)
                    Text("favourites")
                        .tag(Tab.favourites)
                    Text("saved")
                        .tag(Tab.saved)
                    Text("music")
                        .tag(Tab.music)
                    Text("calendar")
                        .tag(Tab.calendar)

                }
                tabBar
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(LoginViewModel())
    }
}

extension MainView{
    
    private var tabBar: some View{
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.mintGreen)
                .frame(height: 35)
                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 20))
            HStack{
                ForEach(Tab.allCases, id: \.self){tab in
                    Spacer()
                    Image(mainVM.currentTab == tab ? tab.isPressed :  tab.rawValue)
                        .padding(5)
                        .onTapGesture {
                            mainVM.currentTab = tab
                        }
                    Spacer()
                }
                
            }
            .offset(y: -5)
            .background{
                Color.mintGreen.ignoresSafeArea()
            }
            .padding(.top, -10)
        }
    }
}


struct CustomCorners: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



//HStack{
//    Text(userManager.currentUser?.userName ?? "")
//    if let url = URL(string: userManager.currentUser?.profileImageUrl ?? "") {
//        WebImageView(imageUrl: url)
//            .frame(width: 80, height: 80)
//    }
//
//}
//Text("MainView")
//Button {
//    loginVM.logOut()
//} label: {
//    Text("logOut")
//}
