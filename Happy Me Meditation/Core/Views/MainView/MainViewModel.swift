//
//  MainViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation


final class MainViewModel: ObservableObject{
    
    
    @Published var currentTab: Tab = .home
    @Published var playAnimation: Bool = false
}


enum Tab: String, CaseIterable {
    case home = "Home"
    case favourites = "Favourites"
    case saved = "Saved"
    case music = "Music"
    case calendar = "Calendar"
    
    var isPressed: String{
        self.rawValue + ".fill"
    }
}
