//
//  CalendarView.swift
//

import SwiftUI
import FSCalendar

/// カレンダーView.
struct CalendarView: UIViewRepresentable {
    
    @ObservedObject var weightData: WeightRecordViewModel
    
    @Binding var isEditorShown: Bool
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.dataSource = context.coordinator
        
        calendar.delegate = context.coordinator
        
        configureCalendar(calendar)
        
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }
    
    func configureCalendar(_ calendar: FSCalendar) {
        // ヘッダーの日付フォーマットを変更
        calendar.appearance.headerDateFormat = "yyyy年MM月dd日"
        // 曜日と今日の色を指定
        calendar.appearance.todayColor = .orange
        calendar.appearance.headerTitleColor = .orange
        calendar.appearance.weekdayTextColor = .black
        // 曜日表示内容を変更
        calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        // 土日の色を変更
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .red
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = .blue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(weightData: weightData, isEditorShow: $isEditorShown)
    }
    
    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate {
        
        @ObservedObject var weightData: WeightRecordViewModel
        
        @Binding var isEditorShow: Bool
        
        init(weightData: WeightRecordViewModel, isEditorShow: Binding<Bool>) {
            self.weightData = weightData
            self._isEditorShow = isEditorShow
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dateList = weightData.recordList.map({ $0.date.zeroclock })
            // 比較対象のDate型の年月日が一致していた場合にtrueとなる
            let isEqualDate = dateList.contains(date.zeroclock)
            return isEqualDate ? 1 : 0
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            calendar.deselect(date)
            guard let record = weightData.recordList.first(where: { $0.date.zeroclock == date.zeroclock }) else {
                return
            }
            weightData.editDate = record.date
            weightData.editWeight = record.weight
            isEditorShow = true
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(weightData: WeightRecordViewModel(), isEditorShown: .constant(false))
    }
}
