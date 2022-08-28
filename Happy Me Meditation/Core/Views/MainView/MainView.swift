//
//  MainView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var audioManager = AudioManager()
    @StateObject var mainVM = MainViewModel()
    @StateObject var userManager = UserManagerViewModel()
    
    @EnvironmentObject var loginVM: LoginViewModel
    

    init(){
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $mainVM.currentTab) {
                NavigationView{
                    HomeView()
                        .environmentObject(audioManager)
                        .navigationBarHidden(true)
                    
                }.tag(Tab.home)
                
                VStack {
                    Text("favourites")
                    
                        .navigationBarHidden(true)
                }
                .tag(Tab.favourites)
                Text("saved")
                    .tag(Tab.saved)
                    .navigationBarHidden(true)
                Text("music")
                    .tag(Tab.music)
                    .navigationBarHidden(true)
                Text("calendar")
                    .tag(Tab.calendar)
                    .navigationBarHidden(true)
            }
            .environmentObject(userManager)
            .environmentObject(mainVM)
            
            tabBar
            
        }
        .fullScreenCover(isPresented: $audioManager.showPlayerView) {
            PlayerView(audioManager: audioManager)
               
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
            if audioManager.isSetAudio{
                playerBarView
            }
            Rectangle()
                .fill(Color.mintGreen)
                .frame(height: 35)
                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: audioManager.isSetAudio ? 0 : 20))
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
    
    private var playerBarView: some View{
        ZStack(alignment: .top) {
            Color.backgroung.opacity(0.6)
            ProgressView(value: audioManager.currentTime, total: audioManager.duration ?? 0)
                .progressViewStyle(LinerProgressStyle())
                .frame(height: 3)
            HStack(spacing: 20) {
                Text(audioManager.plaingAudio?.title ?? "No name")
                    .lineLimit(1)
                    .font(.headline)
                Spacer()
                Text(DateComponentsFormatter.positional.string(from: ((audioManager.duration ?? 0) - audioManager.currentTime)) ?? "0:00")
                    .font(.subheadline)
                
                Button {
                    audioManager.playOrPause()
                } label: {
                    Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .padding(.vertical, 10)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 25)
        }
        .foregroundColor(.white)
        .hCenter()
        .frame(height: 60)
        .background(Material.ultraThinMaterial)
        .onTapGesture {
            audioManager.showPlayerView.toggle()
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






struct LinerProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return  ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                Rectangle()
                    .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                    .foregroundColor(Color.accentOrange)
                    .animation(.linear, value: fractionCompleted)
            }
        }
    }
}

