//
//  HomeViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation


final class HomeViewModel: ObservableObject{
    
    
    let course = MockData.course
    
    
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uploadData()
        }
        
    }
    
    
    
    func uploadData(){
        addData(course: MockData.dailyCourse)
//        MockData.recomendedCourse.forEach { course in
//            addData(course: course)
//        }
    }
    
    
    func addData(course: Course){
        do {
            try FirebaseManager.shared.firestore
                .collection("daily_course")
                .document()
                .setData(from: course, completion: { error in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                    print("data set")
                })
            print("data set finish")
            
        } catch let error{
            print(error.localizedDescription)
        }
        
    }
}



//private func storeUserInformation(_ profileImageUrl: URL?, completion: @escaping () -> Void){
//    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//    let user = User(uid: uid, email: email, profileImageUrl: profileImageUrl?.absoluteString ?? "", userName: userName, firstName: userFirstName, lastName: "", bio: userBio, userBannerUrl: "", phone: "")
//    do {
//        try  FirebaseManager.shared.firestore.collection("users")
//            .document(uid).setData(from: user, completion: { error in
//                if let error = error{
//                    self.handleError(error, title: "Filed to set user data")
//                    return
//                }
//                completion()
//            })
//    } catch {
//        handleError(error, title: "Filed to set user data")
//    }
//
//}
