//
//  FirebaseDataViewModel.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 12/7/24.
//


import Foundation
import Combine
import Firebase

public class FirebaseDataViewModel: ObservableObject {
    @Published var appList = [Appp]()

    private let dbRef = Firestore.firestore().collection("AppList")
    
    func fetchAllSubscribers() {
        var newAppList = [Appp]()

        dbRef.getDocuments { [weak self] snapshot, error in
            guard error == nil else {
                print("[FirebaseDataViewModel] [fetchAllSubscribers] failed with - \(String(describing: error))")
                return
            }

            snapshot?.documents.forEach { document in
                guard
                    let appName = document["appName"] as? String,
                    let appLink = document["appLink"] as? String
                        
                    
                else {
                    print("[FirebaseDataViewModel] [fetchAllSubscribers] Did not find the properties")
                    return
                }

                print("i have found \(appName) \(appLink)")
                newAppList.append(Appp(appName: appName, appLink: appLink))
                print("[FirebaseDataViewModel] [fetchAllSubscribers] \(document.documentID) --> \(document.data())")
            }
            
            guard let self else {
                print("[FirebaseDataViewModel] [fetchAllSubscribers] self is nil")
                return
            }
            
            self.appList = newAppList
        }
    }
}

// MARK: - Models
struct Appp: Identifiable {
    let id = UUID()
    let appName: String
    let appLink: String
}

// MARK: - Extensions
extension String {
    var isNotEmpty: Bool { !isEmpty }
}

