//
//  HomeViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 14.08.2022.
//

import Foundation
import Firebase

final class HomeViewModel: ObservableObject{
    
    
    let course = MockData.course
    
    @Published var shortSessions: [Session]? = []
    @Published var recomendedCourses: [Course]? = []
    @Published var dailyCourses: [Course]? = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    @Published var selectedSession: Session?
    @Published var selectedCourse: Course?
    
    init(){
        fetchSessions()
        fetchDailyCourse()
        fetchRecomendedCourse()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.uploadData()
//        }
        
    }
    
//https://firebasestorage.googleapis.com/v0/b/happy-me-meditation.appspot.com/o/audio%2Fmixkit-just-chill-16.mp3?alt=media&token=5eee7bde-6d2e-4dc8-b199-430a1999df37
    
//    func uploadData(){
//       // addData(course: MockData.dailyCourse)
//        MockData.sessions.forEach { session in
//            addData(course: session)
//        }
//    }
    
    
    func addData(course: Session){
        do {
            try FirebaseManager.shared.firestore
                .collection("short_sessions")
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
    
    
    
    func fetchRecomendedCourse(){
        FirebaseManager.shared.firestore
            .collection("recomended_course")
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
            .collection("daily_course")
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Daily Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    self.saveReturnedCourse(snapshot, courses: &self.recomendedCourses)
                })
            }
    }
    
    func fetchSessions(){
        FirebaseManager.shared.firestore
            .collection("short_sessions")
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




