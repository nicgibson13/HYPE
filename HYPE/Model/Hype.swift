//
//  Hype.swift
//  HYPE
//
//  Created by Nic Gibson on 7/9/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Hype"
    fileprivate static let recordTextKey = "Text"
    fileprivate static let recordTimestampKey = "Date"
}

class Hype {
    
    let hypeText: String
    let timestamp: Date
    
    // Creating a Hype
    init(hypeText: String, timestamp: Date = Date()) {
        self.hypeText = hypeText
        self.timestamp = timestamp
    }
}

extension Hype {
    // Creating a Hype from a record
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[Constants.recordTextKey] as? String,
            let hypeTimeStamp = ckRecord[Constants.recordTimestampKey] as? Date else
        {return nil}
        self.init(hypeText: hypeText, timestamp: hypeTimeStamp)
    }
}

// Creating a CKRecord from a Hype
extension CKRecord {
    convenience init(hype: Hype) {
        self.init(recordType: Constants.recordTypeKey)
        self.setValue(hype.hypeText, forKey: Constants.recordTextKey)
        self.setValue(hype.timestamp, forKey: Constants.recordTimestampKey)
    }
}
