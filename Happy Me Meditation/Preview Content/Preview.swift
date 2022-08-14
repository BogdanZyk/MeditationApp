//
//  Preview.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation
import FirebaseFirestore

final class MockData{
    
    static let course = Course(title: "Take a break", subtitle: "Stop feeling guilty for taking rests and get stronger", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/thom-masat-fOKaK7EjydM-unsplash%201.jpg?alt=media&token=abe37ce2-2913-4ba1-8894-4e7bb63de747", isDaily: false, isNew: true, timestamp: Timestamp.init(date: .now))
    
    static let dailyCourse = Course(title: "Meditation Process", subtitle: "A new lesson on a current topic every day", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fmyles-tan-RFgO9B_OR4g-unsplash%201.jpg?alt=media&token=01900571-64b4-46dc-9892-d80e3f905d05", audioURL: "", isDaily: true, isNew: false)
    
    
    static let recomendedCourse: [Course] = [
    
        Course(title: "Take a break", subtitle: "Stop feeling guilty for taking rests and get stronger", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/thom-masat-fOKaK7EjydM-unsplash%201.jpg?alt=media&token=abe37ce2-2913-4ba1-8894-4e7bb63de747", audioURL: "", isDaily: false, isNew: false),
        
        Course(title: "Safe mind", subtitle: "Make your mind remain a home where you’re safe", duration: 480, courseDuration: 3, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/course_Images%2Fzach-vessels-nqgyiwr2U60-unsplash.jpg?alt=media&token=e6cc4469-5b17-46f6-988d-a5dc464ea6fe", audioURL: "", isDaily: false, isNew: false),
        
        
        Course(title: "Let yourself free", subtitle: "Get rid of boundaries you built around yourself", duration: 720, courseDuration: 6, courseImageUrl: "", audioURL: "", isDaily: false, isNew: false),
        
        
        Course(title: "Stay focused", subtitle: "How to stay focused on work during the day", duration: 300, courseDuration: 3, courseImageUrl: "", audioURL: "", isDaily: false, isNew: false),
        
    ]
    
  
}
