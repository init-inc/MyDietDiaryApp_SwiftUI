//
//  CustomDatePicker.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/15.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var date: Date
    
    let isPickerShown: Bool
    
    var body: some View {
        datePicker
    }
    
    /// 日付ピッカー.
    private var datePicker: some View {
        VStack(spacing: .zero) {
            // 日付ピッカー
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .background {
                    Color(.systemGray6)
                }
        }
        .offset(y: isPickerShown ? 0.0 : 300.0)
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePicker(date: .constant(Date()), isPickerShown: false)
    }
}
