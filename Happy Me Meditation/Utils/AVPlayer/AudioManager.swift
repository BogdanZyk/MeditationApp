//
//  AudioManager.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 20.08.2022.
//

import Foundation
import AVKit
import Combine


final class AudioManager: ObservableObject{
    
    
    var audioPlayer = AVPlayer()
    var audio: Audio?
    @Published var currentRate: Float = 1.0
    @Published var isPlaying: Bool = false
    @Published var currentTime: Double = .zero
    @Published var observedTime: Double = .zero
    @Published var duration: Double?
    private var subscriptions = Set<AnyCancellable>()
    
    
    private var timeObserver: Any?
     
     deinit {
         if let timeObserver = timeObserver {
             audioPlayer.removeTimeObserver(timeObserver)
         }
     }
    
    
    init(){
        startSubscriptions()
    }
    
    public var isEndAudio: Bool{
        currentTime == duration
    }
    
    
    public var isSetAudio: Bool{
        audio != nil && !isEndAudio
    }
    
    
    func setCurrentItem(){
        guard let strUrl = audio?.audioURL, let url = URL(string: strUrl) else {return}
        let item = AVPlayerItem(url: url)
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer.replaceCurrentItem(with: item)
        }catch{
            print("Failed to init player", error)
        }
        item.publisher(for: \.status)
            .filter({ $0 == .readyToPlay })
            .sink(receiveValue: { [weak self] _ in
                self?.duration = item.asset.duration.seconds
            })
            .store(in: &subscriptions)
    }
    
    public func playOrPause(){
        
        if isEndAudio{
            setCurrentItem()
        }
        if isPlaying{
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }
    
    
    public func setBackwardSeconds(_ type: TimeSwitch){
        guard let duration = duration else {return}
        
        var time = currentTime + type.time
        
        if (currentTime < abs(type.time)) && type == .backward{
            time = 0
        }
        
        if duration - currentTime < abs(type.time){
            time = duration
        }
        scrubState = .scrubEnded(time)
    }
    
    var scrubState: PlayerScrubState = .reset {
        didSet {
        switch scrubState {
            case .reset:
                return
            case .scrubStarted:
                return
            case .scrubEnded(let seekTime):
                audioPlayer.seek(to: CMTime(seconds: seekTime, preferredTimescale: 600))
            }
        }
    }
    
    
    private func startSubscriptions(){
        audioPlayer.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                switch status {
                case .playing:
                    self?.isPlaying = true
                case .paused:
                    self?.isPlaying = false
                case .waitingToPlayAtSpecifiedRate:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &subscriptions)
        
        timeObserver = audioPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self else { return }
            
            self.observedTime = time.seconds
            
            switch self.scrubState {
                case .reset:
                    self.currentTime = time.seconds
                case .scrubStarted:
                    break
                case .scrubEnded(let seekTime):
                    self.scrubState = .reset
                    self.currentTime = seekTime
            }
        }
    }
}

enum PlayerScrubState{
    case reset
    case scrubStarted
    case scrubEnded(Double)
}

enum TimeSwitch{
    case backward
    case forward
    
    var time: Double{
        switch self {
        case .backward:
            return -15.0
        case .forward:
            return 15.0
        }
    }
}

