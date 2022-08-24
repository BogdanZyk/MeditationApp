//
//  Course.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


struct Course: Codable, Identifiable{
    
    var id: String = UUID().uuidString
    var title: String?
    var subtitle: String?
    var duration: Int?
    var courseDuration: Int?
    var courseImageUrl: String?
    var isDaily: Bool?
    var isNew: Bool?
    var timestamp: Timestamp = Timestamp(date: .now)
    var audios: [Audio]? = []
    
    var date: String{
        timestamp.dateValue().formatted(date: .abbreviated, time: .omitted)
    }
}


