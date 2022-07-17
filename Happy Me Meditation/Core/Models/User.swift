//
//  User.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import Foundation



struct User: Codable{
    let uid: String
    var email: String
    var profileImageUrl: String?
    var userName: String
}
