//
//  ConfigureButton.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/14.
//

import SwiftUI

struct ConfigureButton: View {
    
    @ObservedObject var weightData: WeightRecordViewModel
    
    @Binding var isEditorShown: Bool
    
    var body: some View {
        HStack {
            Spacer()
            button
        }
    }
    
    /// 体重入力画面遷移ボタン
    private var button: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.orange)
            Text("＋")
                .foregroundColor(Color.white)
                .font(.system(size: 24.0))
                .bold()
        }
        .frame(width: 50.0, height: 50.0, alignment: .bottomTrailing)
        .padding([.bottom, .trailing], 20.0)
        .onTapGesture {
            weightData.getRecord()
            isEditorShown = true
        }
    }
}

struct ConfigureButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureButton(weightData: WeightRecordViewModel(), isEditorShown: .constant(false))
    }
}
