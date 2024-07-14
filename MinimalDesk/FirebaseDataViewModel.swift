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
    @Published var onlyAppName = [String]()

    private let dbRef = Firestore.firestore().collection("AppList")
    
    func saveUserDefault () {
        
        
        let encoder = JSONEncoder()

        do {
            // Encode the array of objects to JSON Data
            let encodedData = try encoder.encode(appList)
            
            // Save the encoded data to UserDefaults
            UserDefaults.standard.set(encodedData, forKey: "saveAppList")
            
            // Synchronize UserDefaults to persist the data immediately (optional)
            UserDefaults.standard.synchronize()
            
            print("Saved array of persons to UserDefaults")
        } catch {
            print("Error encoding or saving array of persons: \(error.localizedDescription)")
        }
        
    }
    
    func getList() {
        
        if let savedData = UserDefaults.standard.data(forKey: "saveAppList") {
            let decoder = JSONDecoder()
            
            do {
                // Decode the JSON Data into an array of Person objects
                let saveAppList = try decoder.decode([Appp].self, from: savedData)
                
                // Use the retrieved array of objects
                print("Retrieved array of persons:")
                for app in saveAppList {
                    print("Retrieved array of persons: \(app.appLink), \(app.appName)")
                }
            } catch {
                print("Error decoding or retrieving array of persons: \(error.localizedDescription)")
            }
        } else {
            print("No saved array of persons data found in UserDefaults")
        }
    }
    
    func fetchAllSubscribers() {
        var newAppList = [Appp]()
        var onlyAppName = [String]()

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

              //  print("i have found \(appName) \(appLink)")
                newAppList.append(Appp(appName: appName, appLink: appLink))
                onlyAppName.append(appName)
               // print("[FirebaseDataViewModel] [fetchAllSubscribers] \(document.documentID) --> \(document.data())")
            }
            
            guard let self else {
               print("[FirebaseDataViewModel] [fetchAllSubscribers] self is nil")
                return
            }
            
            self.appList = newAppList
            self.onlyAppName = onlyAppName
        }
       
    }
    
    
    
}

// MARK: - Models
struct Appp: Codable {
    
    let appName: String
    let appLink: String
}

// MARK: - Extensions
extension String {
    var isNotEmpty: Bool { !isEmpty }
}

