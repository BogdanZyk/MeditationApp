//
//  PlayerView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 20.08.2022.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var audioManager: AudioManager
    var body: some View {
        ZStack(alignment: .top){
            bgImage
            VStack(alignment: .leading, spacing: 0){
             CustomNavigationBar()
                Spacer()
                soundPlayerView
                
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .onAppear{
            if !audioManager.isPlaying{
                audioManager.setAudioItem()
                audioManager.audioPlayer.play()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(audioManager: AudioManager())
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
            if let title = audioManager.plaingAudio?.title{
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
                    if let description = audioManager.plaingAudio?.description{
                        Text(description)
                            .font(.urbRegular(size: 18))
                           
                    }
                }
                .multilineTextAlignment(.center)
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
            PlaybackControlButton(isDisabled: audioManager.selectedAudioIndex == 0, action: {
                audioManager.playForwardAudio()
            })
            Spacer()
            PlayButton(isPlay: !audioManager.isPlaying, action: {
                audioManager.playOrPause()
            })
            Spacer()
            PlaybackControlButton(isNext: true, action: {
                audioManager.playNextAudio()
            })
            Spacer()
            BackwardButton( action: {
                audioManager.setBackwardSeconds(TimeSwitch.forward)
            })
        }
        .padding(.horizontal)
    }
}




