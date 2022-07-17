//
//  LoginViewModel.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import Foundation
import FirebaseFirestoreSwift

final class LoginViewModel: ObservableObject {
    
    @Published var isloggedUser: Bool = false
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    
    
    let userDataService = UserDataService()
    
    init(){
        checkLoginStatus()
    }
    
    private func checkLoginStatus(){
        isloggedUser = FirebaseManager.shared.auth.currentUser?.uid != nil
    }
    
    public func logIn(){
        
    }
}



protocol UserDataServiceProtocol{
    
    func createAccount(email: String, password: String, username: String, completion: @escaping () -> Void)
    func storeUserInformation(email: String, userName: String, completion: @escaping () -> Void)
    func login(email: String, password: String, completion: @escaping () -> Void)
    
}


final class UserDataService: UserDataServiceProtocol {
    
    @Published var showLoader: Bool = false
    @Published var error: Error?
    
    
    func login(email: String, password: String, completion: @escaping () -> Void){
        showLoader = true
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {[weak self] (result, error) in
            guard let self = self else {return}
            self.showLoader = false
            if let err = error{
                self.error = err
                self.showLoader = false
                return
            }
            print("Successfull login, \(result?.user.uid ?? "nil")")
            completion()
        }
    }
    
    func createAccount(email: String, password: String, username: String, completion: @escaping () -> Void){
        showLoader = true
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {[weak self] (result, error) in
            guard let self = self else {return}
            self.showLoader = false
            if let err = error{
                self.error = err
                return
            }
            self.storeUserInformation(email: email, userName: username, completion: completion)
        }
    }
    
    internal func storeUserInformation(email: String, userName: String, completion: @escaping () -> Void){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let user = User(uid: uid, email: email, userName: userName)
        do {
            try  FirebaseManager.shared.firestore.collection("users")
                .document(uid)
                .setData(from: user, completion: { error in
                    if let error = error{
                        self.error = error
                        //self.handleError(error, title: "Filed to set user data")
                        return
                    }
                    completion()
                })
        } catch {
            self.error = error
            //handleError(error, title: "Filed to set user data")
        }
    }
}


