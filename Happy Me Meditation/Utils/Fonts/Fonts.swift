//
//  Fonts.swift
//  LiveChat
//
//  Created by Богдан Зыков on 25.06.2022.
//



import SwiftUI


extension Font {
    static func urbRegular(size: Int) -> Font {
        Font.custom("Urbanist-Regular", size: CGFloat(size))
    }
    static func urbMedium(size: Int) -> Font {
        Font.custom("Urbanist-Medium", size: CGFloat(size))
    }
    
    static func fjallaOne(size: Int) -> Font {
        Font.custom("FjallaOne-Regular.ttf", size: CGFloat(size))
    }


}
