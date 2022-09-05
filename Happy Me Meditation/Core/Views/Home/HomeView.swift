//
//  HomeView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManagerViewModel
    @EnvironmentObject var mainVM: MainViewModel
    @EnvironmentObject var audioManager: AudioManager
    @StateObject private var homeVM = HomeViewModel()
    @State private var showCourseDetails: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 40) {
                    headerView
                    feelTodaySection
                    recentSessionsSection
                    dailyPracticeSection
                    emergencyHelpersSection
                    recommendedCoursesSection
                    newlyAddedSection
                }
                .padding(.horizontal)
                .padding(.bottom, audioManager.isSetAudio ? 130 : 90)
                
                NavigationLink(isActive: $showCourseDetails) {
                    CourseDetailsView(course: homeVM.selectedCourse)
                        .environmentObject(audioManager)
                } label: {
                    EmptyView()
                }
            }
        }
        .foregroundColor(.white)
        .allFrame()
        .background{
            backgroungView
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AudioManager())
            .environmentObject(MainViewModel())
            .environmentObject(UserManagerViewModel())
    }
}


extension HomeView{
    private var backgroungView: some View{
        MainBgView()
    }
}

extension HomeView{
    private var headerView: some View{
        HStack{
            Text("Good Morning\n\(userManager.currentUser?.userName ?? "")")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            UserAvatarViewComponent(pathImage: userManager.currentUser?.profileImageUrl, size: CGSize(width: 76, height: 76))
        }
        .hLeading()
    }
    
    private var feelTodaySection: some View{
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("How you feel today?", subTitle: "You can monitor your mental state in mood\n tracker provided in profile")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(MoodType.allCases, id: \.self) { mood in
                        Button {
                            withAnimation {
                                homeVM.currentMood = mood
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(homeVM.currentMood == mood ? .mintGreen : Color.secondaryGreen)
                                    
                                Text(mood.rawValue)
                                    .font(.largeTitle)
                            }
                            .frame(width: 80, height: 80)
                        }

                        
                    }
                }
                .padding(.leading)
            }.padding(.horizontal, -16)
        }
    }
    
    
    
    private func sectionHeader(_ title: String, subTitle: String) -> some View{
        VStack(alignment: .leading, spacing: 10){
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(subTitle)
                .font(.urbMedium(size: 16))
        }
    }
}


///Recent Sessions
extension HomeView {
    private var recentSessionsSection: some View{
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Recent Sessions", subTitle: "You have uncompleted course. Please, get back to sessions when you’re ready")
            Button {
                homeVM.selectedCourse = MockData.ressentCourse
                showCourseDetails.toggle()
            } label: {
                RessentCourseRowView(course: MockData.ressentCourse)
            }
        }
    }
}

///Daily Practice
extension HomeView{
    private var dailyPracticeSection: some View{
        VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Daily Practice", subTitle: "We suggest you daily quick session according to your goals and preferences")
            
            if let dilyCourse = homeVM.dailyCourses?.first{
                Button {
                    homeVM.selectedCourse = dilyCourse
                    showCourseDetails.toggle()
                } label: {
                    CourseCardViewComponent(course: dilyCourse)
                }
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.secondaryGreen)
                    .frame(width: 300, height: 80)
            }
        }
    }
}

///Emergency helpers
extension HomeView {
    private var emergencyHelpersSection: some View{
        let rows = Array(repeating: GridItem(.fixed(80)), count: 4)
       return VStack(alignment: .leading, spacing: 20) {
            sectionHeader("Emergency helpers", subTitle: "Short sessions will definetely come in handy in stressful situations")
           ScrollView(.horizontal, showsIndicators: false) {
               LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                   if let sessions = homeVM.shortSessions, !sessions.isEmpty{
                       ForEach(sessions.indices, id: \.self) { index in
                           Button {
                               audioManager.audios = sessions.compactMap({$0.audio})
                               audioManager.selectedAudioIndex = index
                               audioManager.showPlayerView.toggle()
                           } label: {
                               SessionRowViewComponent(session: sessions[index])
                           }
                       }
                   }else{
                       ForEach(1...8, id: \.self) { _ in
                           RoundedRectangle(cornerRadius: 20)
                               .fill(Color.secondaryGreen)
                               .frame(width: 300, height: 80)
                       }
                   }
               }
               .padding(.horizontal)
           }
           .padding(.horizontal, -16)
        }
    }
}

///Recommended courses
extension HomeView {
    private var recommendedCoursesSection: some View{
        let rows = Array(repeating: GridItem(.fixed(170)), count: 2)
        return VStack(alignment: .leading, spacing: 20) {
             sectionHeader("Recommended courses", subTitle: "Short sessions will definetely come in handy in stressful situations")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 20) {
                    if let courses = homeVM.recomendedCourses, !courses.isEmpty{
                        ForEach(courses, id: \.id) { course in
                            Button {
                                homeVM.selectedCourse = course
                                showCourseDetails.toggle()
                            } label: {
                                CourseCardViewComponent(course: course)
                            }
                        }
                    }else{
                        ForEach(1...4, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.secondaryGreen)
                                .frame(width: 320, height: 160)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, -16)
        }
    }
}

///Newly Added
extension HomeView {
    private var newlyAddedSection: some View{
        VStack(alignment: .leading, spacing: 20) {
             sectionHeader("Newly Added", subTitle: "Discover updates and try new meditation courses as they come up")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    if let courses = homeVM.newCourses, !courses.isEmpty{
                        ForEach(courses, id: \.id) { course in
                            Button {
                                homeVM.selectedCourse = course
                                showCourseDetails.toggle()
                            } label: {
                                CourseCardViewComponent(course: course)
                            }
                        }
                    }else{
                        ForEach(1...2, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.secondaryGreen)
                                .frame(width: 320, height: 160)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, -16)
        }
    }
}


enum MoodType: String, CaseIterable{
    case engry = "😠"
    case funny = "😃"
    case overwhelmed = "🤯"
    case silly = "🤪"
    case love = "🥰"
}

