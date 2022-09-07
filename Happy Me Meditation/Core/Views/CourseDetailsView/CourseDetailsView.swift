//
//  CourseDetailsView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct CourseDetailsView: View {
    @EnvironmentObject var audioManager: AudioManager
    var course: Course?
    var body: some View {
        VStack(spacing: 0){
            CustomNavigationBar()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    courseTitleSubtitleView
                    courseImage
                    beginCourseButton
                    aboutCourse
                    audioSection
                    downloadButton
                }
                .padding([.horizontal, .top])
                .padding(.bottom, audioManager.isSetAudio ? 130 : 90)
            }
        }
        .onAppear{
            audioManager.audios = course?.audios
        }
        .foregroundColor(.white)
        .background{
            backgroungView
        }
        .navigationBarHidden(true)
    }
}

struct CourseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailsView(course: MockData.recomendedCourse.first!)
            .environmentObject(AudioManager())
    }
}


extension CourseDetailsView{
    
    private var backgroungView: some View{
        MainBgView()
    }
    
    private var courseTitleSubtitleView: some View{
        VStack(spacing: 10) {
            Text(course?.title ?? "")
                .font(.title)
                .fontWeight(.bold)
            Text(course?.subtitle ?? "")
                .multilineTextAlignment(.center)
                .font(.urbRegular(size: 18))
        }
    }
    
    private var courseImage: some View{
        ZStack{
            if let image = course?.courseImageUrl{
                CustomLazyImage(strUrl: image, resizingMode: .fill)
            }
        }
        .frame(height: 200)
        .cornerRadius(20)
    }
    
    private var beginCourseButton: some View{
        Button {
            audioManager.selectedAudioIndex = 0
            audioManager.showPlayerView.toggle()
        } label: {
            HStack{
                Text("Begin course")
                Image(systemName: "play.fill")
                    .font(.subheadline)
            }
            .font(.urbMedium(size: 20))
            .foregroundColor(.black)
            .hCenter()
            .frame(height: 55)
            .background(Color.accentOrange)
            .cornerRadius(10)
        }
    }
    
    private var aboutCourse: some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
                .font(.title2)
                .fontWeight(.bold)
            Text("A beginner’s meditation course that gives some initial teaching and introduces the basic techniques. The program will gently immerse you in the practice and will touch important aspects of daily life")
                .font(.urbMedium(size: 16))
        }
        .hLeading()
    }
    
    private var downloadButton: some View{
        Button {
            
        } label: {
            HStack{
                Text("Download full course")
                Image("download")
                    .renderingMode(.template)
            }
            .font(.urbMedium(size: 20))
            .foregroundColor(.accentOrange)
            .hCenter()
            .frame(height: 55)
            .background(Color.accentOrange, in: RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}


extension CourseDetailsView{
    
    private var audioSection: some View{
        VStack(alignment: .leading, spacing: 10) {
            if let audios = course?.audios{
                ForEach(audios.indices, id: \.self) { index in
                    Button {
                        audioManager.selectedAudioIndex = index
                        audioManager.showPlayerView.toggle()
                    } label: {
                        audioRowView(audios[index], index: index)
                    }
                }
            }
        }
    }
    
    
    private func audioRowView(_ audio: Audio, index: Int) -> some View{
        
        HStack(alignment: .top, spacing: 20){
            ZStack{
                Color.emerald
                Text("\(index + 1)")
                    .font(.urbMedium(size: 18))
            }
            .frame(width: 25, height: 25)
            .clipShape(Circle())
            VStack(alignment: .leading, spacing: 5){
                Text(audio.title ?? "")
                Text("\((audio.duration ?? 0).secondsToMin())")
                    .foregroundColor(.fontSecondary.opacity(0.6))
                    .font(.urbMedium(size: 14))
            }
            Spacer()
            Button {
                
            } label: {
                Image("download")
                    .padding(.vertical, 10)
            }

        }
        .padding(.horizontal)
        .hLeading()
        .frame(height: 72)
        .background{
            LinearGradient(colors: [.black.opacity(0.3), .black.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .cornerRadius(10)
    }
}
