//
//  GraphView.swift
//  MyDietDiaryApp_SwiftUI
//
//  Created by 武久 なおき on 2023/08/15.
//

import SwiftUI
import Charts

struct GraphView: UIViewRepresentable {
    
    @ObservedObject var weightData: WeightRecordViewModel
    
    func makeUIView(context: Context) -> LineChartView {
        let graph = LineChartView()
        updateGraph(graph)
        configureGraph(graph)
        graph.delegate = context.coordinator
        return graph
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = setData()
        configureGraph(uiView)
    }
    
    func updateGraph(_ graph: LineChartView) {
        var entry = [ChartDataEntry]()
        weightData.graphList.enumerated().forEach({ index, record in
            let data = ChartDataEntry(x: Double(index), y: record.weight)
            entry.append(data)
        })
        let dataSet = LineChartDataSet(entries: entry, label: "体重")
        graph.data = LineChartData(dataSet: dataSet)
        graph.data?.notifyDataChanged()
        graph.notifyDataSetChanged()
    }
    
    func configureGraph(_ graph: LineChartView) {
        graph.xAxis.labelPosition = .bottom
        let titleFormatter = GraphDataTitleFormatter()
        let dateList = weightData.graphList.map({ $0.date })
        titleFormatter.dateList = dateList
        graph.xAxis.valueFormatter = titleFormatter
    }
    
    func setData() -> LineChartData {
        var entry = [ChartDataEntry]()
        weightData.graphList.enumerated().forEach({ index, record in
            let data = ChartDataEntry(x: Double(index), y: record.weight)
            entry.append(data)
        })
        let dataSet = LineChartDataSet(entries: entry, label: "体重")
        return LineChartData(dataSet: dataSet)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(weightData: weightData)
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        
        @ObservedObject var weightData: WeightRecordViewModel
        
        init(weightData: WeightRecordViewModel) {
            self.weightData = weightData
        }
        
        override func didChangeValue(forKey key: String) {
            weightData.sortRecord()
        }
    }
}

struct GraphContentView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(weightData: WeightRecordViewModel())
    }
}
