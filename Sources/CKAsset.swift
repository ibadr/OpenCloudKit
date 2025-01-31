//
//  CKAsset.swift
//  OpenCloudKit
//
//  Created by Benjamin Johnson on 16/07/2016.
//
//

import Foundation

public class CKAsset: NSObject {
    
    public var fileURL : NSURL
    
    var recordKey: String?
    
    var uploaded: Bool = false
    
    var downloaded: Bool = false
    
    var recordID: CKRecordID?
    
    var downloadBaseURL: String?
        
    var downloadURL: URL? {
        get {
            if let downloadBaseURL = downloadBaseURL {
                if let urlstring = downloadBaseURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                    if let theURL = URL(string: urlstring) {
                        return theURL
                    } else {
                        return nil
                    }
                } else {return nil}
            } else {
                return nil
            }
        }
    }
    
    var size: UInt?
    
    var hasSize: Bool {
        return size != nil
    }
    
    var uploadReceipt: String?
    
    public init(fileURL: NSURL) {
        self.fileURL = fileURL
    }
    
    init?(dictionary: [String: Any]) {
        
        guard
        let downloadURL = dictionary["downloadURL"] as? String,
        let size = dictionary["size"] as? NSNumber
        else  {
            return nil
        }
       
        let downloadURLString = downloadURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        fileURL = NSURL(string: downloadURLString)!
        self.downloadBaseURL = downloadURL
        self.size = size.uintValue
        downloaded = false

    }
}

extension CKAsset: CustomDictionaryConvertible {
    public var dictionary: [String: Any] {
        var fieldDictionary: [String: Any] = [:]
        if let recordID = recordID, let recordKey = recordKey {
            fieldDictionary["recordName"] = recordID.recordName.bridge()
        //    fieldDictionary["recordType"] = "Items".bridge()
            fieldDictionary["fieldName"] = recordKey.bridge()
        }
        
        return fieldDictionary
    }
}
