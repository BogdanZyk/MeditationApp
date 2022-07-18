//
//  LoginViewModel.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var isloggedUser: Bool = false
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var error: Error?
    
    let userDataService: UserDataService
    
    init(userDataService: UserDataService =  UserDataService()){
        self.userDataService = userDataService
        checkLoginStatus()
    }
    
    
    public var isValidLoginForms: Bool{
        !email.isEmpty && !password.isEmpty
    }
    
    
    private func checkLoginStatus(){
        isloggedUser = FirebaseManager.shared.auth.currentUser?.uid != nil
    }
    
    public func logIn(){
        isLoading = true
        userDataService.logIn(email: email, password: password) { [weak self] (result) in
            self?.isLoading = false
            self?.handleResult(result)
        }
    }
    
    public func createAccount(){
        isLoading = true
        userDataService.createAccount(email: email, password: password, username: userName) { [weak self] (result) in
            self?.isLoading = false
            self?.handleResult(result)
        }
    }
    
    public func logOut(){
        userDataService.logOut { [weak self] in
            self?.checkLoginStatus()
        }
    }
    
    private func handleError(_ error: Error){
        self.error = error
        showAlert = true
    }
    
    private func handleResult(_ result: Result<Bool, Error>){
        switch result{
        case .success(let success):
            isloggedUser = success
            resetUserInfo()
        case .failure(let error):
            handleError(error)
        }
    }
    
    private func resetUserInfo(){
        email.removeAll()
        password.removeAll()
    }
}






