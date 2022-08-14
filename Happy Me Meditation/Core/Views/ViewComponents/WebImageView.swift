//
//  WebImageView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    var contentMode: ContentMode = .fill
    let imageUrl: URL
    var body: some View {
        WebImage(url: imageUrl)
            .placeholder{
                Color.secondaryGreen
            }
            .centerCropped()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        WebImageView(imageUrl: URL(string: "")!)
    }
}
