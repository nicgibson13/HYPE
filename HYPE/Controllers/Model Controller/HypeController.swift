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
    
    static let sharedInstance = HypeController()
    
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
            self.hypes.insert(hype, at: 0)
            completion(true)
        }
    }
    // Fetch
    func fetchDemHypes(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let hypeQuery = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        hypeQuery.sortDescriptors = [NSSortDescriptor(key: Constants.recordTimestampKey, ascending: false)]
        publicDB.perform(hypeQuery, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else {completion(false); return}
            let hypes = records.compactMap({Hype(ckRecord: $0)})
            self.hypes = hypes
            completion(true)
        }
    }
    
    // Subscription
    func subcribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
}
