//
//  ChartInfoCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 15/01/2023.
//

import UIKit

class ChartInfoCell: UITableViewCell {

    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var chartFIlterDropDown: UIView!
    
    private lazy var chart: FLChart = {
        let config = FLBarConfig(radius: .corners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], 8), width: 22, spacing: 28, limitWidth: true)
        // empty data
        let chartData = FLChartData(title: "", data: ["" : 0], legendKeys: [
            Key(key: "F1", color: .Gradient.purpleCyan, disableColor: .uiColor(UIColor(red: 191/255, green: 203/255, blue: 1, alpha: 1)))],
         unitOfMeasure: "h")
        
        let chart = FLChart(data: chartData, type: .bar(bar: FLPlainChartBar.self, highlightView: BarHighlightedView(), focusView: BarFocusView(), config: config))
        chart.showTicks = false
        chart.config = .init(granularityX: 1, dashedLines: .init(color: UIColor(hex: "E5E5EF"), lineWidth: 1.22, dashWidth: 10))
        chart.shouldScroll = true
        chartContainer.addSubview(chart)
        return chart
    }()
    
    func configure(with chartData: Any) {
        circularProgressView.progressAnimation(to: 0.5, duration: 1)
        
        configureMockChart()
    }
    
    private func configureMockChart() {
        let timeData = [SinglePlotable(name: "T2", value: CGFloat(1)),
                        SinglePlotable(name: "T3", value: CGFloat(1)),
                        SinglePlotable(name: "T4", value: CGFloat(1)),
                        SinglePlotable(name: "T5", value: CGFloat(2)),
                        SinglePlotable(name: "T6", value: CGFloat(0)),
                        SinglePlotable(name: "Hôm nay", value: CGFloat(4)),
                        SinglePlotable(name: "CN", value: CGFloat(6))]
 
        let chartData = FLChartData(title: "",
                                    data: timeData,
                                    legendKeys: [
                                        Key(key: "F1", color: .Gradient.purpleCyan, disableColor: .uiColor(UIColor(red: 191/255, green: 203/255, blue: 1, alpha: 1)))],
                                     unitOfMeasure: "h")
        
        chart.updateChart(data: timeData)
//        chart.translatesAutoresizingMaskIntoConstraints = false
//        chartContainer.addSubview(chart)
//
//        NSLayoutConstraint.activate([
//            chart.leadingAnchor.constraint(equalTo: chartContainer.leadingAnchor),
//            chart.trailingAnchor.constraint(equalTo: chartContainer.trailingAnchor),
//            chart.topAnchor.constraint(equalTo: chartContainer.topAnchor),
//            chart.topAnchor.constraint(equalTo: chartContainer.bottomAnchor)
//        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chart.frame = chartContainer.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circularProgressView.circleColor = Colors.chartCirle
        circularProgressView.progressColor =  Colors.appPrimary
        chartFIlterDropDown.layer.cornerRadius = 6.5
        chartFIlterDropDown.layer.borderWidth = 0.65
        chartFIlterDropDown.layer.borderColor = Colors.border.cgColor
    }
}

extension ChartInfoCell: NibLoadableView {}
