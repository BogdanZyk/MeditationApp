//
//  FavouriteView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var audioManager: AudioManager
    @StateObject var favouriteVM = FavouriteViewModel()
    @State private var selected: Int = 0
    @State private var showCourseDetails: Bool = false
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.accentOrange)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(.secondaryGreen.opacity(0.65))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
           navigationBar
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(alignment: .leading, spacing: 20) {
                    switch selected{
                    case 0:
                        coursesSection
                    case 1:
                        audioSectionView
                    default:
                        coursesSection
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 120)
                
                NavigationLink(isActive: $showCourseDetails) {
                    CourseDetailsView(course: favouriteVM.selectedCourse)
                        .environmentObject(audioManager)
                } label: {
                    EmptyView()
                }
            }
        }
        .foregroundColor(.white)
        .allFrame()
        .background{
            MainBgView()
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
            .environmentObject(AudioManager())
    }
}


extension FavouriteView{
    private var navigationBar: some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("My favourite")
                .font(.title)
                .bold()
            Picker("", selection: $selected) {
                Text("Courses").tag(0)
                Text("Audio").tag(1)
            }
            .pickerStyle(.segmented)
        }
        .padding([.horizontal, .bottom])
    }
}

//Courses
extension FavouriteView{
    
    private var coursesSection: some View{
            Group {
                if let courses = favouriteVM.favouriteCourses, !courses.isEmpty{
                    ForEach(courses, id: \.id) { course in
                        Button {
                            favouriteVM.selectedCourse = course
                            showCourseDetails.toggle()
                        } label: {
                            CourseCardViewComponent(course: course, isFullSize: true)
                        }
                    }
                }
            }
    }
}


//Audio
extension FavouriteView{
    
    private var audioSectionView: some View{
        Group {
            if let favouriteAudios = favouriteVM.favouriteAudio, !favouriteAudios.isEmpty{
                ForEach(favouriteAudios.indices, id: \.self) { index in
                    Button {
                        audioManager.audios = favouriteAudios.compactMap({$0.audio})
                        audioManager.selectedAudioIndex = index
                        audioManager.showPlayerView.toggle()
                    } label: {
                        SessionRowViewComponent(session: favouriteAudios[index], isFullWidth: true)
                    }
                }
            }else{
                Text("No Added")
            }
        }
    }
    
}
