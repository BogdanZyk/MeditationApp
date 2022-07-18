//
//  OnboardingView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 18.07.2022.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentStep: Int = 0
    @State private var isStarted: Bool = true
    var body: some View {
        ZStack{
            Color.backgroung.ignoresSafeArea()
            VStack(spacing: 0) {
                switch currentStep{
                case 0:
                    step1
                case 1:
                    step2
                case 2:
                    step3
                default:
                    EmptyView()
                }
                buttonsSectionView
            }
            .padding(.horizontal, 20)
        }
        .fullScreenCover(isPresented: $isStarted) {
            welcomeView
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

extension OnboardingView{
    
    
    private var welcomeView: some View{
        ZStack{
            Color.backgroung.ignoresSafeArea()
            VStack(spacing: 0){
                VStack(spacing: 25) {
                    Image("welcome")
                        .resizable()
                        .frame(maxHeight: 545)
                        .padding(.horizontal, -20)
                    Text("Welcome to Carefree")
                        .font(.fjallaOne(size: 30))
                        .foregroundColor(.white)
                    Text("Take a deep breath and begin your healing hourney with Carefree today")
                        .font(.urbMedium(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.fontSecondary)
                    CustomButton(title: "Get Started", height: 55, fontSize: 20) {
                        isStarted.toggle()
                    }
                    .padding(.vertical, 20)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    private var buttonsSectionView: some  View{
        VStack(spacing: 40) {
            pageControlView
            HStack(spacing: 0) {
                Button {
                  dismiss()
                } label: {
                    Text("Skip")
                        .font(.urbMedium(size: 18))
                        .foregroundColor(.accentOrange)
                }
                Spacer()
                CustomButton(title: "Next") {
                    if currentStep != 2{
                        withAnimation(.easeInOut) {
                            currentStep += 1
                        }
                    }else{
                        dismiss()
                    }
                }
                .frame(width: 150)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    private func stepsContentView(_ step: OnboardStep) -> some View{
        VStack(spacing: 20) {
            Image(step.image)
                .resizable()
                .frame(height: 470)
                .padding(.horizontal, -20)
            Text(step.title)
                .font(.fjallaOne(size: 30))
                .foregroundColor(.white)
            Text(step.description)
                .font(.urbMedium(size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.fontSecondary)
                .padding(.horizontal, 40)
        }
    }
    private var step1: some View{
        stepsContentView(OnboardConstants.step1)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    private var step2: some View{
        stepsContentView(OnboardConstants.step2)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    private var step3: some View{
        stepsContentView(OnboardConstants.step3)
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    private var pageControlView: some View{
        HStack(spacing: 5) {
            ForEach(0...2, id: \.self){ index in
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.accentOrange)
                    .frame(width: index == currentStep ? 40 : 15, height: 8)
                    .opacity(index == currentStep ? 1 : 0.5)
            }
        }
    }
}



