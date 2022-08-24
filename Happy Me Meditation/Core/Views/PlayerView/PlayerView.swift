//
//  PlayerView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 20.08.2022.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    @Environment(\.dismiss) var dismiss
    var audio: Audio?
    var body: some View {
        ZStack{
            bgImage
            VStack(alignment: .leading, spacing: 0){
                navBarView
                Spacer()
                soundPlayerView
                
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .onAppear{
            if let audio = audio, !audioManager.isPlaying {
                audioManager.audio = audio
                audioManager.setCurrentItem()
                audioManager.audioPlayer.play()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(AudioManager())
    }
}

extension PlayerView{
    private var bgImage: some View{
        Image("playerBg")
            .resizable()
            .scaledToFill()
            .frame(width: getRect().width)
            .ignoresSafeArea()
            .scaleEffect(1.1)
            .blur(radius: 5)
    }
    
    private var navBarView: some View{
        HStack(spacing: 20){
            Button {
                dismiss()
            } label: {
                iconView("leftArrow", size: CGSize(width: 20, height: 20))
            }
            Spacer()
            Button {
                
            } label: {
                iconView("Favourites")
            }
            Button {
                
            } label: {
                iconView("Saved")
            }
            Button {
                
            } label: {
                iconView("share")
            }
            
        }
        .foregroundColor(.white)
        .padding(.horizontal)
    }
    
    private func iconView(_ icon: String, size: CGSize = CGSize(width: 25, height: 25)) -> some View{
        Image(icon)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
    }
}


extension PlayerView{
    private var soundPlayerView: some View{
        VStack(alignment: .center, spacing: 10){
            soundInfoView
            sliderView
            playbackControlSection
        }
    }
    
    
    private var soundInfoView: some View{
        Group{
            if let title = audio?.title{
                VStack(spacing: 20) {
                    ZStack{
                        Color.white.opacity(0.15)
                        Image("Music")
                            .renderingMode(.template)
                            .frame(width: 50, height: 50)
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    if let description = audio?.description{
                        Text(description)
                            .font(.urbRegular(size: 18))
                            .multilineTextAlignment(.center)
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
    

    
    private var sliderView: some View{
        VStack(alignment: .leading, spacing: 10){
            
            Slider(value: $audioManager.currentTime,
                   in: (0...(audioManager.duration ?? 100)),
                      onEditingChanged: { (scrubStarted) in
                if scrubStarted {
                    self.audioManager.scrubState = .scrubStarted
                } else {
                    self.audioManager.scrubState = .scrubEnded(audioManager.currentTime)
                }
            })
            HStack{
                Text(DateComponentsFormatter.positional.string(from: audioManager.currentTime) ?? "0:00")
                Spacer()
                Text(DateComponentsFormatter.positional.string(from: ((audioManager.duration ?? 0) - audioManager.currentTime)) ?? "0:00")
            }
            .font(.urbMedium(size: 14))
            .foregroundColor(.white)
        }
    }
    
    private var playbackControlSection: some View{
        HStack(spacing: 0){
            BackwardButton(isForward: false, action: {
                audioManager.setBackwardSeconds(TimeSwitch.backward)
            })
            Spacer()
            PlaybackControlButton(action: {})
            Spacer()
            PlayButton(isPlay: !audioManager.isPlaying, action: {
                audioManager.playOrPause()
            })
            Spacer()
            PlaybackControlButton(isNext: true, action: {})
            Spacer()
            BackwardButton( action: {
                audioManager.setBackwardSeconds(TimeSwitch.forward)
            })
        }
        .padding(.horizontal)
    }
}



