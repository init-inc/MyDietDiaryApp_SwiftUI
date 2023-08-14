//
//  EditorView.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/14.
//

import SwiftUI

struct EditorView: View {
    
    @State private var date = ""
    
    @State private var weight = ""
    
    var body: some View {
        VStack(spacing: 20.0) {
            dateInput
            weightInput
            Spacer()
        }
    }
    
    private var dateInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("日付")
                .font(.system(size: 17.0))
            TextField("", text: $date)
                .textFieldStyle(.roundedBorder)
        }
        .padding([.top, .leading, .trailing], 40.0)
    }
    
    private var weightInput: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("体重")
                .font(.system(size: 17.0))
            TextField("", text: $weight)
                .textFieldStyle(.roundedBorder)
        }
        .padding([.leading, .trailing], 40.0)
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
