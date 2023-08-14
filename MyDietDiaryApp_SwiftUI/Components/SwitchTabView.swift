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
    
    var body: some View {
        tab
    }
    
    private var tab: some View {
        TabView(
            selection: $sectionTagNumber,
            content: {
                
            }
        )
    }
}

struct SwitchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchTabView(sectionTagNumber: .constant(0))
    }
}
