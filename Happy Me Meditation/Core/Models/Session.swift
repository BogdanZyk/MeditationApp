//
//  Session.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 20.08.2022.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Session: Codable, Identifiable{
    var id: String = UUID().uuidString
    var title: String?
    var duration: Int?
    var imageUrl: String?
    var audioURL: String?
}




