//
//  HomeViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation
import Firebase

final class HomeViewModel: ObservableObject{
    
    

    
    @Published var shortSessions: [Session]? = []
    @Published var newCourses: [Course]? = []
    @Published var recomendedCourses: [Course]? = []
    @Published var dailyCourses: [Course]? = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    @Published var selectedCourse: Course?
    
    init(){
        fetchSessions()
        fetchDailyCourse()
        fetchRecomendedCourse()
        fetchNewCourses()
    }
    

    func fetchRecomendedCourse(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.RECOMENDED_COURSES)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Recomended Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    self.saveReturnedCourse(snapshot, courses: &self.recomendedCourses)
                })
            }
    }
    
    func fetchDailyCourse(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.DAILY_COURSE)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch New Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    self.saveReturnedCourse(snapshot, courses: &self.dailyCourses)
                })
            }
    }
    
    func fetchNewCourses() {
        FirebaseManager.shared.firestore
            .collection(FBConstants.NEW_COURSES)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Daily Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    self.saveReturnedCourse(snapshot, courses: &self.newCourses)
                })
            }
    }
    
    func fetchSessions(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.SHORT_SESSIONS)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Sessions")
                documentSnapshot?.documents.forEach({ snapshot in
                    do{
                        let returnedSessions = try snapshot.data(as: Session.self)
                        self.shortSessions?.append(returnedSessions)
                    }catch{
                        self.handleError(error, title: "Failed to decode course data")
                    }
                })
            }
    }
    
    
    
    private func saveReturnedCourse(_ snapshot: QueryDocumentSnapshot, courses: inout [Course]?){
        do{
            let returnedCourse = try snapshot.data(as: Course.self)
            courses?.append(returnedCourse)
        }catch{
            self.handleError(error, title: "Failed to decode course data")
        }
    }
    
    private func handleError(_ error: Error?, title: String){
        Helpers.handleError(error, title: title, errorMessage: &errorMessage, showAlert: &showAlert)
    }
}




