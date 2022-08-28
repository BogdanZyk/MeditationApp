//
//  Preview.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation
import FirebaseFirestore

final class MockData{
    
    static let course = Course(title: "Take a break", subtitle: "Stop feeling guilty for taking rests and get stronger", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/thom-masat-fOKaK7EjydM-unsplash%201.jpg?alt=media&token=abe37ce2-2913-4ba1-8894-4e7bb63de747", isDaily: false, isNew: true, timestamp: Timestamp.init(date: .now), audios: audios)
    
    static let dailyCourse = Course(title: "Meditation Process", subtitle: "A new lesson on a current topic every day", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fmyles-tan-RFgO9B_OR4g-unsplash%201.jpg?alt=media&token=01900571-64b4-46dc-9892-d80e3f905d05", isDaily: true, isNew: false, audios: audios)
    
    
    static let recomendedCourse: [Course] = [
    
        Course(title: "Take a break", subtitle: "Stop feeling guilty for taking rests and get stronger", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/thom-masat-fOKaK7EjydM-unsplash%201.jpg?alt=media&token=abe37ce2-2913-4ba1-8894-4e7bb63de747", isDaily: false, isNew: false, audios: audios),
        
        Course(title: "Safe mind", subtitle: "Make your mind remain a home where you’re safe", duration: 480, courseDuration: 3, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe", isDaily: false, isNew: false, audios: audios),
        
        
        Course(title: "Let yourself free", subtitle: "Get rid of boundaries you built around yourself", duration: 720, courseDuration: 6, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fclem-onojeghuo-hAhInPdviCk-unsplash%201.jpg?alt=media&token=a106f1b4-2076-4bb1-a3eb-669e2fb9faf9", isDaily: false, isNew: false, audios: audios),
        
        
        Course(title: "Stay focused", subtitle: "How to stay focused on work during the day", duration: 300, courseDuration: 3, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Freka-illyes-qBjamUksW9s-unsplash.jpg?alt=media&token=26a9522c-c4b2-491b-9048-e43795e80f20", isDaily: false, isNew: false, audios: audios),
        
    ]
    
  

    
    static var sessions: [Session] {
        
        var returnedSessions: [Session] = []

        audiosData.forEach{ data in
            let duration: Int = (60...180).randomElement() ?? 60
            let session = Session( title: data.key, imageUrl: "", audio: Audio(title: data.key, description: "How to keep focus on your needs during the day in such a hectic world", duration: duration, audioURL: data.value))
            returnedSessions.append(session)
        }
        
        return returnedSessions
    }
        

            
//    Session(title: "Overcome the blues", imageUrl: "", audio: Audio(title: "Overcome the blues", description: "How to keep focus on your needs during the day in such a hectic world", duration: 120, audioURL: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe")),
//    Session(title: "Focus on work",imageUrl: "", audio: Audio(title: "Focus on work", description: "How to keep focus on your needs during the day in such a hectic world", duration: 180, audioURL: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe")),
//    Session(title: "Better Sleep",imageUrl: "", audio: Audio(title: "Better Sleep", description: "How to keep focus on your needs during the day in such a hectic world", duration: 220, audioURL: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe")),
//    Session(title: "Numb pain",imageUrl: "", audio: Audio(title: "Numb pain", description: "How to keep focus on your needs during the day in such a hectic world", duration: 320, audioURL: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe")),
//    Session(title: "Prepare for a meeting",imageUrl: "", audio: Audio(title: "Prepare for a meeting", description: "How to keep focus on your needs during the day in such a hectic world", duration: 220, audioURL: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe")),
//    Session(title: "Deal with panic",imageUrl: "", audio: Audio(title: "Deal with panic", description: "How to keep focus on your needs during the day in such a hectic world", duration: 480, audioURL: audiosData.randomElement()?.value)),
//    Session(title: "Better Sleep",imageUrl: "", audio: Audio(title: "Better Sleep", description: "How to keep focus on your needs during the day in such a hectic world", duration: 120, audioURL: audiosData.randomElement()?.value)),
//    Session(title: "Get rid of anger",imageUrl: "", audio: Audio(title: "Get rid of anger", description: "How to keep focus on your needs during the day in such a hectic world", duration: 120, audioURL: audiosData.randomElement()?.value))
//
    //]
    
    static var audiosData: [String: String] = [
        "Deep Relaxation": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-spiritual-moment-525.mp3?alt=media&token=a8b042b9-5851-4252-8953-553914d401e5",
        
        "Genuine interest in yourself": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-song-of-kindness-524.mp3?alt=media&token=bd21f959-4646-4356-a199-80f7b835799e",
        
        "A new good habit": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-smooth-meditation-324.mp3?alt=media&token=ba5e6ce1-60cd-4e51-a2c8-b4884d3ab422",
        
        "A clear and calm mind": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-relaxation-meditation-365.mp3?alt=media&token=a84cce85-df95-43ba-9cd1-3cdaffd65a42",
        
        "Healthy thoughts": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-pan-pipes-magic-17.mp3?alt=media&token=c1488fca-9ef4-47e5-a5cb-c5f844f648fc",
        
        "Numb pain": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-just-chill-16.mp3?alt=media&token=5eee7bde-6d2e-4dc8-b199-430a1999df37",
        
        "Better Sleep": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-fhloston-paradise-arrival-156.mp3?alt=media&token=daf58765-ec52-44fe-b031-95b45a2aabda",
        
        "Get rid of anger": "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-yoga-song-444.mp3?alt=media&token=8dd4b7e4-4555-4e70-ab46-13426d4fe2b9"
            
    ]

    
    static var audios: [Audio]{
        
       
        var audios: [Audio] = []
        
        //titles.shuffle()
        
        audiosData.forEach { data in
            let duration: Int = (60...180).randomElement() ?? 60
            let audio = Audio(title: data.key, description: "How to keep focus on your needs during the day in such a hectic world", duration: duration, audioURL: data.value)
            audios.append(audio)
        }
        return audios
        
    }
    
    
    
}


