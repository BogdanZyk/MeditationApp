//
//  SavedCourseView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct SavedCourseView: View {
    @EnvironmentObject var audioManager: AudioManager
    @StateObject var savedCourseVM = SaveCourseViewModel()
    @State private var showCourseDetails: Bool = false
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            navtitle
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(alignment: .leading, spacing: 20) {
                    coursesSection
                }
                .padding(.horizontal)
                NavigationLink(isActive: $showCourseDetails) {
                    CourseDetailsView(course: savedCourseVM.selectedCourse)
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

struct SavedCourseView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCourseView()
            .environmentObject(AudioManager())
    }
}


extension SavedCourseView {
    private var navtitle: some View{
        VStack{
            Text("My Saved Course")
                .font(.title)
                .bold()
        }
        .padding([.bottom, .horizontal])
    }
    
    
    private var coursesSection: some View{
            Group {
                if let courses = savedCourseVM.savedCourses, !courses.isEmpty{
                    ForEach(courses, id: \.id) { course in
                        Button(action: {
                            savedCourseVM.selectedCourse = course
                            showCourseDetails.toggle()
                        }, label: {
                            CourseCardViewComponent(course: course, isFullSize: true)
                        })
                        
                    }
                }
            }
    }
}

