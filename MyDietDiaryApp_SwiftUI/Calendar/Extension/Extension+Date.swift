//
//  Extension+Date.swift
//

import Foundation

extension Date {
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale = Locale(identifier: "ja-JP")
        return calendar
    }
    
    func fixed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, miniute: Int? = nil, second: Int? = nil) -> Date {
        var comp = DateComponents()
        comp.year = year ?? calendar.component(.year, from: self)
        comp.month = month ?? calendar.component(.month, from: self)
        comp.day = day ?? calendar.component(.day, from: self)
        comp.hour = hour ?? calendar.component(.hour, from: self)
        comp.minute = miniute ?? calendar.component(.minute, from: self)
        comp.second = second ?? calendar.component(.second, from: self)
        return calendar.date(from: comp)!
    }
    
    var zeroclock: Date {
        return fixed(hour: 0, miniute: 0, second: 0)
    }
}
