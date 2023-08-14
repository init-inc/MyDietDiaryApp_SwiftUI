//
//  WeightRecordModel.swift
//

import Foundation
import RealmSwift

class WeightRecordModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date
    @Persisted var weight: Double
    
    convenience init(date: Date, weight: Double) {
        self.init()
        self.date = date
        self.weight = weight
    }
}
