//
//  TwigCarouselView.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 07.09.2022.
//

import SwiftUI

struct TwigCarouselView: View {
    @State private var currenIndex: Int = 0
    var body: some View {
        VStack {
            HStack(spacing: 0){
                twigImage()
                    value
                
                twigImage(true)
            }
            controlButtons
        }
        .foregroundColor(.white)
    }
}

struct TrigCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroung
            TwigCarouselView()
        }
    }
}


extension TwigCarouselView{
    private func twigImage(_ isReversed: Bool = false) -> some View{
        Image("twig")
            .resizable()
            .frame(width: 126, height: 170)
            .aspectRatio(contentMode: .fill)
            .rotation3DEffect(.degrees(isReversed ? 180 : 0), axis: (x: 0, y: -1, z: 0))
    }
    
    private var value: some View{
        Group{
            switch currenIndex{
            case 0:
                statContent(title: "total time", value: "657 min")
            case 1:
                statContent(title: "All course", value: "28")
            case 2:
                statContent(title: "count sessions", value: "89")
            default:
                EmptyView()
            }
        }
        .transition(.move(edge: .trailing).combined(with: .opacity))
    }
    
    private func statContent(title: String, value: String) -> some View{
        VStack(spacing: 10) {
            Text(title.uppercased())
                .font(.urbRegular(size: 18))
            Text(value)
                .font(.title3)
                .bold()
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
    
    private var controlButtons: some View{
        HStack(alignment: .center){
            Button {
                withAnimation {
                currenIndex = currenIndex != 0 ? (currenIndex - 1) : 2
                }
            } label: {
                Image(systemName: "arrow.left")
                    .padding(10)
            }
            
            ForEach(0...2, id: \.self) { index in
                Image(index == currenIndex ? "pageControl.fill" : "pageControl")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15, height: 25)
                    
            }
            .padding(.top, 5)
            Button {
                withAnimation {
                    currenIndex = currenIndex != 2 ? (currenIndex + 1) : 0
                }
            } label: {
                Image(systemName: "arrow.right")
                    .padding(10)
            }
        }
        .font(.subheadline)
    }
}



