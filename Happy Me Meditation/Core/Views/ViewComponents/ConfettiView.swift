//
//  ConfettiView.swift
//  Homecooks
//
//  Created by Богдан Зыков on 26.08.2022.
//

import SwiftUI

struct ConfettiView: View {
  
    @Binding var show: Bool
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.accentOrange)
                .frame(width: 15, height: 15)
                .offset(x: 10, y: 20)
            Circle()
                .fill(Color.mintGreen) .frame(width: 10, height: 10)
                .offset(x: -15, y: -25)
        }
        .modifier(ParticlesModifier(show: $show))
    }
}

struct ConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiView(show: .constant(true))
    }
}


struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 50 ... 130)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct ParticlesModifier: ViewModifier {
    @Binding var show: Bool
    @State var time = 0.0
    @State var scale = 0.4
    let duration = 1.8
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<30, id: \.self) { index in
                content
                    //.hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
                show = false
            }
        }
    }
}
