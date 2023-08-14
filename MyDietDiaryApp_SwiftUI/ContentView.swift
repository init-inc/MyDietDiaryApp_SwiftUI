//
//  ContentView.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/14.
//

import SwiftUI

struct ContentView: View {
    /// 画面更新時に初期化されないようにStateObject使用.
    /// 体重記録ViewModel.
    @StateObject var weightData = WeightRecordData()
    /// 現在開いているタブのインデックス.
    @State private var index = 0
    
    var body: some View {
        // タブ＋コンテントView
        SwitchTabView(weightData: weightData, sectionTagNumber: $index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weightData: WeightRecordData())
    }
}
