//
//  PlaybackControlButton.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 21.08.2022.
//

import SwiftUI

struct PlaybackControlButton: View {
    var isDisabled: Bool = false
    var isNext: Bool = false
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image("stopPlay")
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundColor(.white)
                .rotationEffect(Angle.degrees(isNext ? 180 : 0))
        }
        .opacity(isDisabled ? 0.3 : 1)
        .disabled(isDisabled)
    }
}

struct PlaybackControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            HStack {
                BackwardButton( action: {})
                PlaybackControlButton(isDisabled: true, action: {})
                PlayButton(isPlay: false, action: {})
                PlaybackControlButton(isNext: true, action: {})
                BackwardButton(isForward: false, action: {})
            
            }
        }
    }
}


struct BackwardButton: View{
    var isForward: Bool = true
    var imageName: String{
        isForward ? "goforward" : "gobackward"
    }
    var action: () -> Void
    var body: some View{
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.headline)
                Text("15 sec")
                    .font(.urbMedium(size: 12))
            }
            .foregroundColor(.white)
        }
    }
}



struct PlayButton: View{
    var isPlay: Bool
    var action: () -> Void
    var body: some View{
        Button {
            action()
        } label: {
            ZStack{
                Color.white.opacity(0.1)
                Image(systemName: isPlay ? "play.fill" : "pause.fill")
                    .font(.title2)
            }
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .clipShape(Circle())
        }
    }
}
