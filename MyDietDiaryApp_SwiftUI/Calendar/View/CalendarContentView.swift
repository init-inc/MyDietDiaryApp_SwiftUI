//
//  CalendarContentView.swift
//

import SwiftUI
import FSCalendar

/// カレンダーView.
struct CalendarContentView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        typealias UIViewType = FSCalendar
        
        let calendar = FSCalendar()
        
        configureCalendar(calendar)
        
        return calendar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // 空白
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
}

struct CalendarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContentView()
    }
}
