//
//  RessentCourseRowView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct RessentCourseRowView: View {
    var course: Course?
    var body: some View {
        ZStack(alignment: .topLeading){
            image
            titleSubtitle
        }
        .foregroundColor(.white)
        .frame(width: getRect().width - 32)
        .frame(height: 173)
        .cornerRadius(20)
    }
}

struct RessentCourseRowView_Previews: PreviewProvider {
    static var previews: some View {
        RessentCourseRowView(course: MockData.ressentCourse)
    }
}

extension RessentCourseRowView{
    private var image: some View{
        ZStack(alignment: .bottom){
            ZStack{
                if let image = course?.courseImageUrl{
                    CustomLazyImage(strUrl: image)
                }
                LinearGradient(colors: [.black.opacity(0.4), .clear], startPoint: .leading, endPoint: .trailing)
            }
            progressSection
        }
    }
    
    private var titleSubtitle: some View{
        VStack(alignment: .leading, spacing: 10){
            Text(course?.title ?? "")
                .font(.title3)
                .bold()
            Text(course?.subtitle ?? "")
                .font(.urbMedium(size: 12))
                .frame(width: 160, alignment: .leading)
        }
        .padding()
    }
    
    private var progressSection: some View{
        VStack(alignment: .leading, spacing: 10){
            progressViewComponent
            HStack{
                Text("1 of 15 days")
                Spacer()
                Text("40% completed")
            }
            .font(.urbRegular(size: 12))
        }
        .padding()
        .background(Material.ultraThinMaterial)
    }
    
    
    
    
    ///hartCode progress
    private var progressViewComponent: some View{
        ProgressView(value: 0.4, total: 1.0)
            .progressViewStyle(LinerProgressStyle(line1Color:  .white.opacity(0.3), line2Color: .white))
            .frame(height: 3)
    }
}
