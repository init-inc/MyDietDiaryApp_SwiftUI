//
//  DatePickerTextField.swift
//  

import SwiftUI
import UIKit

// TODO: UIViewController出ないと表現できない可能性が高いため一旦使わずに保留
struct DatePickerTextField: UIViewRepresentable {
    
    @ObservedObject var weightData: WeightRecordData
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.inputView = datePicker
        textField.text = dateFormatter.string(from: weightData.weightEntries.date)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
    }
    
    var dateFormatter: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateStyle = .long
        dateFormatt.timeZone = .current
        dateFormatt.locale = Locale(identifier: "ja-JP")
        return dateFormatt
    }
    
    var datePicker: UIDatePicker {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.date = Date()
        return datePicker
    }
}
