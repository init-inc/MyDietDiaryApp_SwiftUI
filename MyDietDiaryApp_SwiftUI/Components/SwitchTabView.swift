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
    @ObservedObject var weightData: WeightRecordViewModel
    /// 機能ごとのタグ番号.
    @Binding var sectionTagNumber: Int
    /// スタート日変更のDatePicker.
    @State var isStartPickerShown = false
    /// エンド日変更のDatePicker.
    @State var isEndPickerShown = false
    /// 記録画面表示フラグ.
    @State private var isEditorShown = false
    
    var body: some View {
        // セクションごとのView
        tab
            .sheet(
                isPresented: $isEditorShown,
                content: {
                    // 記録画面
                    EditorView(weightData: weightData, date: weightData.editDate, weight: String(ceil(weightData.editWeight)), isEditorShown: $isEditorShown)
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
                    CalendarView(weightData: weightData, isEditorShown: $isEditorShown)
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
                    ConfigureButton(weightData: weightData, isEditorShown: $isEditorShown)
                }
                .tabItem {
                    VStack {
                        Image("CalendarIcon")
                    }
                }
                .tag(0)
                ZStack(alignment: .bottom) {
                    VStack(spacing: .zero) {
                        Spacer()
                        HStack {
                            Text("期間")
                            CustomDateTextField(date: $weightData.startDate, isPickerShown: $isStartPickerShown)
                                .frame(height: 35.0)
                            Text("ー")
                                .padding(.horizontal, 8.0)
                            CustomDateTextField(date: $weightData.endDate, isPickerShown: $isEndPickerShown)
                                .frame(height: 35.0)
                        }
                        .padding(.horizontal, 16.0)
                        // グラフ画面
                        GraphView(weightData: weightData)
                            .padding(
                                EdgeInsets(
                                    top: 40.0,
                                    leading: 20.0,
                                    bottom: 100.0,
                                    trailing: 20.0
                                )
                            )
                    }
                    .onTapGesture {
                        withAnimation {
                            isStartPickerShown = false
                            isEndPickerShown = false
                            weightData.sortRecord()
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.closeKeyboard()
                    }
                    CustomDatePicker(date: $weightData.startDate, isPickerShown: isStartPickerShown)
                        .transition(.move(edge: .bottom))
                    CustomDatePicker(date: $weightData.endDate, isPickerShown: isEndPickerShown)
                        .transition(.move(edge: .bottom))
                }
                .onAppear {
                    weightData.sortRecord()
                }
                .tabItem {
                    VStack {
                        Image("GraphIcon")
                    }
                }
                .tag(1)
            }
        )
    }
}

struct SwitchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchTabView(weightData: WeightRecordViewModel(), sectionTagNumber: .constant(0))
    }
}
