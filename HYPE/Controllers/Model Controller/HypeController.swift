//
//  HypeController.swift
//  HYPE
//
//  Created by Nic Gibson on 7/9/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    //MARK: - Hype cannot be controlled
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var hypes: [Hype] = []
    
    //
    
    // CRUD
    
    // Save
    func saveHype(text: String, completion: @escaping (Bool) -> Void) {
        let hype = Hype(hypeText: text)
        let hypeRecord = CKRecord(hype: hype)
        publicDB.save(hypeRecord) { (_, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
            // Use the hype you created on line 25 to append to the source of truth
            self.hypes.append(hype)
            completion(true)
        }
    }
    // Fetch
    func fetchDemHypes(completion: @escaping (Bool) -> Void) {
        
    }
    
    // Subscription
    func subcribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
}
