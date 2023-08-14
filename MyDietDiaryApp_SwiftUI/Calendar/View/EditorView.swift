//
//  EditorView.swift
//

import SwiftUI
import RealmSwift

struct EditorView: View {
    /// 体重記録ViewModel.
    @ObservedObject var weightData: WeightRecordData
    /// 日付選択ピッカーの表示フラグ.
    @State private var isDatePickerShown = false
    /// 仮の体重値.
    @State private var weight = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 20.0) {
                // 日付入力フォーム
                dateInput
                // 体重入力フォーム
                weightInput
                Spacer()
                // 保存ボタン
                saveButton
            }
            // 日付選択ピッカー
            datePicker
                .transition(.move(edge: .bottom))
        }
    }
    
    /// 日付選択フォーム.
    private var dateInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("日付")
                .font(.system(size: 17.0))
            // SwiftUIではTextFieldにカスタム性がないためViewを切り離して再現
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray6), lineWidth: 1.0)
                HStack {
                    Text(dateFormatter.string(from: weightData.weightEntries.date))
                        .padding(.leading, 8.0)
                    Spacer()
                }
            }
            .frame(height: 35.0)
            .onTapGesture {
                withAnimation {
                    isDatePickerShown.toggle()
                }
            }
        }
        .padding([.top, .leading, .trailing], 40.0)
    }
    
    /// 日付TextField.
    private var datePicker: some View {
        VStack(spacing: .zero) {
            // 日付TextField
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 35.0)
                HStack {
                    Button("done") {
                        withAnimation {
                            isDatePickerShown = false
                        }
                    }
                    .padding(.leading, 16.0)
                    Spacer()
                }
            }
            // 日付ピッカー
            DatePicker("", selection: $weightData.weightEntries.date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .background {
                    Color(.systemGray6)
                }
        }
        .offset(y: isDatePickerShown ? 0.0 : 300.0)
    }
    
    /// 体重TextField.
    private var weightInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("体重")
                .font(.system(size: 17.0))
            TextField("", text: $weight)
                .textFieldStyle(.roundedBorder)
        }
        .padding([.leading, .trailing], 40.0)
    }
    
    /// 保存ボタン.
    private var saveButton: some View {
        ZStack {
            Rectangle()
                .fill(Color.orange)
                .frame(height: 40.0)
            Text("保存")
                .font(.system(size: 15.0))
                .foregroundColor(Color.white)
        }
        .padding(.horizontal, 40.0)
        .padding(.bottom, 100.0)
        .onTapGesture {
            weightData.saveRecord(dateText: weightData.weightEntries.date, weightText: weight)
        }
    }
}

extension EditorView {
    var dateFormatter: DateFormatter {
        let dateFormatt = DateFormatter()
        dateFormatt.dateStyle = .long
        dateFormatt.timeZone = .current
        dateFormatt.locale = Locale(identifier: "ja-JP")
        return dateFormatt
    }
}

/// ピッカーを閉じる処理.
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(weightData: WeightRecordData())
    }
}
