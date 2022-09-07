//
//  SaveCourseViewModel.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 05.09.2022.
//

import SwiftUI

class SaveCourseViewModel: ObservableObject {
    

    @Published var savedCourses: [Course]? = []
    
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    @Published var selectedCourse: Course?
    
    init(){
        fetchSavedCourse()
    }
    
    func fetchSavedCourse(){
        FirebaseManager.shared.firestore
            .collection(FBConstants.RECOMENDED_COURSES)
            .getDocuments {[weak self] (documentSnapshot, error) in
                guard let self = self else {return}
                self.handleError(error, title: "Failed to fetch Recomended Course")
                documentSnapshot?.documents.forEach({ snapshot in
                    do{
                        let returnedCourse = try snapshot.data(as: Course.self)
                        self.savedCourses?.append(returnedCourse)
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

