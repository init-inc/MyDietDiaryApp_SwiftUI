//
//  WeightRecordData.swift
//

import Foundation
import RealmSwift

/// 体重記録ViewModel.
class WeightRecordData: ObservableObject {
    /// 体重記録データ.
    @Published var weightEntries = WeightRecordModel()
    /// 体重記録配列.
    @Published var recordList: [WeightRecordModel] = []
    
    /// 体重記録保存処理.
    func saveRecord(dateText: Date?, weightText: String) {
        let realm = try! Realm()
        try! realm.write {
            if let date = dateText {
                weightEntries.date = date
            }
            if let weight = Double(weightText) {
                weightEntries.weight = weight
            }
            realm.add(weightEntries)
        }
    }
    
    /// 体重記録をRealmから取得.
    func getRecord() {
        let realm = try! Realm()
        let results = realm.objects(WeightRecordModel.self)
        recordList = Array(results)
    }
}
