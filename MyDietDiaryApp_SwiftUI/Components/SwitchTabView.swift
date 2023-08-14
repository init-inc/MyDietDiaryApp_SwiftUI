//
//  SwitchTabView.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/14.
//

import SwiftUI

/// 機能切替タブボタン.
struct SwitchTabView: View {
    /// 機能ごとのタグ番号.
    @Binding var sectionTagNumber: Int
    
    @State private var isEditorShow = false
    
    var body: some View {
        tab
            .sheet(
                isPresented: $isEditorShow,
                content: {
                    EditorView()
                }
            )
    }
    
    private var tab: some View {
        TabView(
            selection: $sectionTagNumber,
            content: {
                VStack(spacing: .zero) {
                    CalendarContentView()
                        .padding(
                            EdgeInsets(
                                top: 150.0,
                                leading: 20.0,
                                bottom: 100.0,
                                trailing: 20.0
                            )
                        )
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
        SwitchTabView(sectionTagNumber: .constant(0))
    }
}
