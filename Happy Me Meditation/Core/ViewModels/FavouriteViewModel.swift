//
//  FavouriteViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 28.08.2022.
//

import Foundation
import Firebase

final class FavouriteViewModel: ObservableObject{
    
    
    @Published var favouriteAudio: [Session]? = []
    @Published var favouriteCourses: [Course]? = []
    
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    @Published var selectedCourse: Course?
    
    init(){
        fetchFavouriteCourse()
        fetchFavouriteAudio()
        
    }
    
    
    func fetchFavouriteCourse(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.RECOMENDED_COURSES)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Recomended Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    do{
                        let returnedCourse = try snapshot.data(as: Course.self)
                        self.favouriteCourses?.append(returnedCourse)
                    }catch{
                        self.handleError(error, title: "Failed to decode course data")
                    }
                })
            }
    }
    
    
    func fetchFavouriteAudio(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.SHORT_SESSIONS)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Sessions")
                documentSnapshot?.documents.forEach({ snapshot in
                    do{
                        let returnedSessions = try snapshot.data(as: Session.self)
                        self.favouriteAudio?.append(returnedSessions)
                    }catch{
                        self.handleError(error, title: "Failed to decode course data")
                    }
                })
            }
    }
    
    

    
    private func handleError(_ error: Error?, title: String){
        Helpers.handleError(error, title: title, errorMessage: &errorMessage, showAlert: &showAlert)
    }
}
    
