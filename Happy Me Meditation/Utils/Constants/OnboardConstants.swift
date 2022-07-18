//
//  OnboardConstants.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import Foundation


class OnboardConstants {
    
    
    
   
    
    static let step1 = OnboardStep(title: "Audio Courses", image: "audio", description: "Increase productivity and conciousness with audio courses. Monitor your progress.")
    static let step2 = OnboardStep(title: "Meditations", image: "meditations", description: "Learn how to cope with bad thoughts, express emotions, and understand your needs better.")
    static let step3 = OnboardStep(title: "Better Sleep", image: "sleep", description: "Do relaxing meditations before going to bed and have a good sleep during the night.")
    
}


struct OnboardStep{
    let title: String
    let image: String
    let description: String
}

