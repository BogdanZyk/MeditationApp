//
//  LaunchView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 07.09.2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack{
            MainBgView()
            Text("Carefree")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
