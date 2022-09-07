//
//  DateValue.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 05.09.2022.
//

import Foundation


struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
