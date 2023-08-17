//
//  DatePickerTextField.swift
//  

import SwiftUI
import UIKit

// TODO: 値の更新ができないため一旦使用停止
struct DatePickerTextField: UIViewRepresentable {
    
    @Binding var date: Date
    
    func makeUIView(context: Context) -> UIView {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.inputView = datePicker
        textField.text = dateFormatter.string(from: date)
        
        return textField
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
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
        datePicker.date = date
        return datePicker
    }
}
