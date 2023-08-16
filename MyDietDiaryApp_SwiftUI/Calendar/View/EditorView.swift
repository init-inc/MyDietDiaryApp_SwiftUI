//
//  EditorView.swift
//

import SwiftUI
import RealmSwift

struct EditorView: View {
    /// 体重記録ViewModel.
    @ObservedObject var weightData: WeightRecordData
    /// 体重記録から渡された日付.
    @State var date: Date
    /// 体重記録から渡された体重.
    @State var weight: String
    /// 日付選択ピッカーの表示フラグ.
    @State private var isDatePickerShow = false
    /// 入力画面表示フラグ.
    @Binding var isEditorShow: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isDatePickerShow = false
                        UIApplication.shared.closeKeyboard()
                    }
                }
            VStack(spacing: 20.0) {
                // 日付入力フォーム
                dateInput
                // 体重入力フォーム
                weightInput
                Spacer()
                // 保存ボタン
                saveButton
                // 削除ボタン
                deleteButton
            }
            // 日付選択ピッカー
            CustomDatePicker(date: $date, isPickerShow: isDatePickerShow)
                .transition(.move(edge: .bottom))
        }
        .ignoresSafeArea(.keyboard)
    }
    
    /// 日付選択フォーム.
    private var dateInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("日付")
                .font(.system(size: 17.0))
            // SwiftUIではTextFieldにカスタム性がないためViewを作り直して再現
            CustomDateTextField(date: $date, isPickerShow: $isDatePickerShow)
                .frame(height: 35.0)
        }
        .padding([.top, .leading, .trailing], 40.0)
    }
    
    /// 体重TextField.
    private var weightInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("体重")
                .font(.system(size: 17.0))
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray5), lineWidth: 1.0)
                TextField("", text: $weight)
                    .keyboardType(.numberPad)
                    .padding(.horizontal, 8.0)
            }
            .frame(height: 35.0)
        }
        .padding([.leading, .trailing], 40.0)
    }
    
    /// 保存ボタン.
    private var saveButton: some View {
        Button(
            action: {
                weightData.saveRecord(dateText: date, weightText: weight)
                isEditorShow = false
            }, label: {
                ZStack {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(height: 40.0)
                    Text("保存")
                        .font(.system(size: 15.0))
                        .foregroundColor(Color.white)
                }
            }
        )
        .padding(.horizontal, 40.0)
    }
    
    /// 保存ボタン.
    private var deleteButton: some View {
        Button(
            action: {
                weightData.deleteRecord()
                isEditorShow = false
            }, label: {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 40.0)
                    Text("削除")
                        .font(.system(size: 15.0))
                        .foregroundColor(Color.red)
                }
            }
        )
        .padding([.horizontal, .bottom], 40.0)
        .padding(.top, 20.0)
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
        EditorView(weightData: WeightRecordData(), date: Date(), weight: "0.0", isEditorShow: .constant(true))
    }
}
