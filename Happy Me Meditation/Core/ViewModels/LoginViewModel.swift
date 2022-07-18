//
//  LoginViewModel.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var isloggedUser: Bool = false
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var error: Error?
    private var cancellable =  Set<AnyCancellable>()
    
    let userDataService: UserDataService
    
    init(userDataService: UserDataService =  UserDataService()){
        self.userDataService = userDataService
        checkLoginStatus()
        startSubscriptions()
    }
    
    
    private func startSubscriptions(){
        userDataService.$showLoader
            .combineLatest(userDataService.$error)
            .dropFirst()
            .sink(receiveValue: { (isLoading, error) in
                if let err = error{
                    self.error = err
                    self.showAlert = true
                }
                self.isLoading = isLoading
            })
            .store(in: &cancellable)
    }
    
    
    private func checkLoginStatus(){
        isloggedUser = FirebaseManager.shared.auth.currentUser?.uid != nil
    }
    
    public func logIn(){
        userDataService.logIn(email: email, password: password) { [weak self] in
            self?.checkLoginStatus()
        }
    }
    public func createAccount(){
        userDataService.createAccount(email: email, password: password, username: userName) { [weak self] in
            self?.checkLoginStatus()
        }
    }
    public func logOut(){
        userDataService.logOut { [weak self] in
            self?.checkLoginStatus()
        }
    }
}






