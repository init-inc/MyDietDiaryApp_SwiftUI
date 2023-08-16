//
//  CustomDateTextField.swift
//

import SwiftUI

struct CustomDateTextField: View {
    
    @Binding var date: Date
    
    @Binding var isPickerShow: Bool
    
    var body: some View {
        textField
    }
    
    private var textField: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.systemGray5), lineWidth: 1.0)
            HStack {
                Text(dateFormatter.string(from: date))
                    .font(.system(size: 15.0))
                    .padding(.horizontal, 8.0)
                Spacer()
            }
        }
        .onTapGesture {
            withAnimation {
                isPickerShow.toggle()
            }
        }
        .frame(height: 35.0)
    }
}

extension CustomDateTextField {
    var dateFormatter: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateStyle = .long
        dateFormatt.timeZone = .current
        dateFormatt.locale = Locale(identifier: "ja-JP")
        return dateFormatt
    }
}

struct CustomDateTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomDateTextField(date: .constant(Date()), isPickerShow: .constant(false))
    }
}
