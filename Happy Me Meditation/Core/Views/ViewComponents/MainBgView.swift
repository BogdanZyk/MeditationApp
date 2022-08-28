//
//  MainBgView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import SwiftUI

struct MainBgView: View {
    var body: some View {
        ZStack(alignment: .top){
            Color.backgroung.ignoresSafeArea()
                Image("homeBgImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                Image("bgIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: 250)
        }.ignoresSafeArea()
    }
}

struct MainBgView_Previews: PreviewProvider {
    static var previews: some View {
        MainBgView()
    }
}
