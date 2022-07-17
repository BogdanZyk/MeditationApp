//
//  UserAvatarViewComponent.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import SwiftUI

struct UserAvatarViewComponent: View {
    let pathImage: String?
    var size: CGSize = .init(width: 37, height: 37)
    var body: some View {
        Group{
            if let image = pathImage, let imageUrl = URL(string: image){
                WebImageView(imageUrl: imageUrl)
            }else{
                ZStack{
                    Color.gray
                    Image("avatarDefault")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .clipShape(Circle())
    }
}

struct UserAvatarViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarViewComponent(pathImage: nil)
    }
}
