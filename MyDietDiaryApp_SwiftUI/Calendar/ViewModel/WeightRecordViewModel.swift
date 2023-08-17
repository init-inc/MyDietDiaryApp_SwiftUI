//
//  WeightRecordData.swift
//

import Foundation
import RealmSwift

/// 体重記録データ.
class WeightRecordViewModel: ObservableObject {
    /// 体重記録配列.
    @Published var recordList: [WeightRecordModel] = []
    /// グラフに表示する配列.
    @Published var graphList: [WeightRecordModel] = []
    /// 編集する日時.
    @Published var editDate = Date()
    /// 編集する体重記録.
    @Published var editWeight = 0.0
    /// グラフに表示するスタート日.
    @Published var startDate: Date
    /// グラフに表示するエンド日.
    @Published var endDate: Date
    
    init(
        startDate: Date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(),
        endDate: Date = Date()
    ) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    /// 体重記録保存処理.
    func saveRecord(dateText: Date?, weightText: String) {
        let realm = try! Realm()
        let record = WeightRecordModel()
        try! realm.write {
            if let date = dateText {
                record.date = date
            }
            if let weight = Double(weightText) {
                record.weight = weight
            }
            realm.add(record)
        }
    }
    
    /// 体重記録削除処理.
    func deleteRecord() {
        let calendar = Calendar(identifier: .gregorian)
        let startOfDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: editDate)!
        let endOfDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: editDate)!
        let realm = try! Realm()
        // NSPredicateを使用した条件検索
        let recordList = Array(realm.objects(WeightRecordModel.self).filter("date BETWEEN {%@, %@}", startOfDate, endOfDate))
        recordList.forEach { record in
            try! realm.write {
                realm.delete(record)
            }
        }
    }
    
    /// グラフ表示のためのソート.
    func sortRecord() {
        let filterStartRecord = recordList.filter { $0.date >= startDate }
        var filterEndRecord = filterStartRecord.filter { $0.date <= endDate }
        filterEndRecord.sort(by: { $0.date < $1.date })
        graphList = filterEndRecord
    }
    
    /// 体重記録をRealmから取得.
    func getRecord() {
        let realm = try! Realm()
        let results = realm.objects(WeightRecordModel.self)
        DispatchQueue.main.async {
            self.recordList = Array(results)
        }
    }
}
