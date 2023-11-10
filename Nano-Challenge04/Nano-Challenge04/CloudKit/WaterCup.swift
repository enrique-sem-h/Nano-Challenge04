//
//  WaterCup.swift
//  Nano-Challenge04
//
//  Created by Enrique Carvalho on 10/11/23.
//

import Foundation
import CloudKit

struct WaterCup{
    var record: CKRecord?
    var ml: Float
    var date: Date
    
    init(record: CKRecord? = nil, ml: Float) {
        self.record = record
        self.ml = ml
        self.date = Date.now
    }
    
    init(record: CKRecord? = nil, ml: Float, date: Date) {
        self.record = record
        self.ml = ml
        self.date = date
    }
    
    func convertToDictionary() -> [String : Any]{
        return ["ml" : ml, "date" : date]
    }
}
