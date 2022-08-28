//
//  SessionRowViewComponent.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 20.08.2022.
//

import SwiftUI

struct SessionRowViewComponent: View {
    var session: Session?
    var isFullWidth: Bool = false
    var width: CGFloat{
        isFullWidth ? getRect().width - 32 : getRect().width / 1.2
    }
    var body: some View {
        ZStack(alignment: .leading) {
            imageSection
            titleSection
        }
        .cornerRadius(20)
        .frame(width: width, height: 80)
    }
}

struct SessionRowViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        Button {
            
        } label: {
            SessionRowViewComponent(session: MockData.sessions.first!)
        }
    }
}


extension SessionRowViewComponent{
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 10) {
            Text(session?.title ?? "")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("Duration: \((session?.audio?.duration ?? 0).secondsToMin())")
                .font(.urbMedium(size: 12))
                .foregroundColor(.fontSecondary.opacity(0.6))
        }
        .padding(.leading)
    }
    
    private var imageSection: some View{
        ZStack{
            if let image = session?.imageUrl{
                CustomLazyImage(strUrl: image)
            }
            LinearGradient(colors: [.black.opacity(0.4), .clear], startPoint: .leading, endPoint: .trailing)
        }
    }
}
