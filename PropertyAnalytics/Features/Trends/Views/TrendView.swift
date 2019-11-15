//
//  TrendView.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/14/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Charts

class TrendView: LineChartView {
    
    let chartViewModel = ChartViewModel()

    // MARK: - Initializer Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        chartDescription?.enabled = false
        doubleTapToZoomEnabled = false
        dragEnabled = false
        pinchZoomEnabled = false
        setupXAxis()
        setupYAxis()
        setupLegend()
    }
    
    private func setupYAxis() {
        leftAxis.spaceTop = 0.15
        leftAxis.spaceBottom = 0.2
        if #available(iOS 13.0, *) { leftAxis.labelTextColor = .label }
        else { leftAxis.labelTextColor = .black }
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        leftAxis.gridColor = .lightGray
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.granularity = 1
        leftAxis.drawBottomYLabelEntryEnabled = false
        leftAxis.axisMaxLabels = 0
        leftAxis.enabled = false
        
        rightAxis.enabled = true
        rightAxis.spaceTop = 0.15
        rightAxis.spaceBottom = 0.2
        rightAxis.labelTextColor = .black
        rightAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        rightAxis.gridColor = .lightGray
        rightAxis.drawGridLinesEnabled = true
        rightAxis.drawAxisLineEnabled = false
        rightAxis.axisMaxLabels = 5
    }
    
    private func setupXAxis() {
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.avoidFirstLastClippingEnabled = false
        xAxis.granularity = 1
        xAxis.spaceMin = 1
        xAxis.spaceMax = 1
        xAxis.labelCount = 2
        xAxis.enabled = false
    }
    
    private func setupLegend() {
        legend.enabled = false
        legend.textColor = .black
        legend.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = -10
        legend.xOffset = 15
        legend.yEntrySpace = 0
    }
        
    func generateLineData(dataPoints: [String], values: [Double]) {
        var entries = [ChartDataEntry]()
        
        xAxis.labelTextColor = .black
        setVisibleXRange(minXRange: 0, maxXRange: Double(dataPoints.count - 1))
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            entries.append(dataEntry)
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.setColor(NSUIColor.black)
        dataSet.setCircleColors(NSUIColor.black)
        dataSet.valueTextColor = UIColor.darkText
        dataSet.mode = .cubicBezier
        dataSet.valueFont = NSUIFont.systemFont(ofSize: 10, weight: .light)
        dataSet.circleRadius = 0
        dataSet.circleHoleRadius = 0
        dataSet.drawValuesEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        dataSet.axisDependency = .right
        rightAxis.axisMaximum = dataSet.yMax * 1.1
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)

        let lineChartData = LineChartData(dataSet: dataSet)
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: ChartViewModel.decimalFormatter)
        lineChartData.setValueFormatter(DefaultValueFormatter(formatter: ChartViewModel.decimalFormatter))
                
        data = lineChartData
        self.fitScreen()
    }

}

class ChartViewModel: NSObject, IAxisValueFormatter, IValueFormatter {
    static var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 4
        formatter.negativeSuffix = "%"
        formatter.positiveSuffix = "%"
        return formatter
    }()
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let formattedValue = "\(value)%"
        return formattedValue
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let formattedValue = "\(value)%"
        return formattedValue
    }
}


