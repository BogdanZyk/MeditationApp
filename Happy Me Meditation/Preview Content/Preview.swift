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
    
    static let dailyCourse = Course(title: "Take a break", subtitle: "Stop feeling guilty for taking rests and get stronger", duration: 360, courseDuration: 12, courseImageUrl: "https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/thom-masat-fOKaK7EjydM-unsplash%201.jpg?alt=media&token=abe37ce2-2913-4ba1-8894-4e7bb63de747", isDaily: true, isNew: false, timestamp: Timestamp.init(date: .now))
    
}
