//
//  SwitchTabView.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/14.
//

import SwiftUI

/// 機能切替タブボタン.
struct SwitchTabView: View {
    /// 体重記録データ.
    @ObservedObject var weightData: WeightRecordData
    /// 機能ごとのタグ番号.
    @Binding var sectionTagNumber: Int
    /// 記録画面表示フラグ.
    @State private var isEditorShow = false
    
    var body: some View {
        // セクションごとのView
        tab
            .sheet(
                isPresented: $isEditorShow,
                content: {
                    // 記録画面
                    EditorView(weightData: weightData)
                        .onDisappear {
                            // 記録画面を閉じるときに新しい記録取得し直す
                            weightData.getRecord()
                        }
                }
            )
    }
    
    /// セクションごとのコンテントView.
    private var tab: some View {
        TabView(
            selection: $sectionTagNumber,
            content: {
                VStack(spacing: .zero) {
                    // カレンダー画面
                    CalendarContentView(weightData: weightData, isEditorShow: $isEditorShow)
                        .padding(
                            EdgeInsets(
                                top: 150.0,
                                leading: 20.0,
                                bottom: 100.0,
                                trailing: 20.0
                            )
                        )
                        .onAppear {
                            weightData.getRecord()
                        }
                    // 記録画面へ遷移するボタン
                    ConfigureButton(isEditorShow: $isEditorShow)
                }
                .tabItem {
                    Text("カレンダー")
                }
                .tag(0)
            }
        )
    }
}

struct SwitchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchTabView(weightData: WeightRecordData(), sectionTagNumber: .constant(0))
    }
}
