//
//  FLChart.swift
//  FLCharts
//
//  Created by Francesco Leoni on 18/01/22.
//

import UIKit

public final class FLChart: UIView, FLStylable {
        
    public enum PlotType {
        case bar(bar: ChartBar.Type = FLPlainChartBar.self,
                 highlightView: HighlightedView? = nil,
                 focusView: HighlightedView? = nil,
                 config: FLBarConfig = FLBarConfig())
    }
    
    public private(set) var cartesianPlane: FLCartesianPlane
    
    internal private(set) var plotView: FLPlotView

    public private(set) var chartData: FLChartData
    
    internal var horizontalRepresentedValues: Bool
    
    public internal(set) var title: String = ""
    public internal(set) var legendKeys: [Key] = []
    public internal(set) var formatter: FLFormatter = .decimal(2)

    /// Whether the chart should scroll. The chart will start scrolling once there is bar outside of the right bound.
    ///
    /// - note: This property can be enabled only while using bar charts.
    public var shouldScroll: Bool = true {
        didSet {
            if let barPlotView = plotView as? FLBarPlotView {
                barPlotView.shouldScroll = shouldScroll
            }
        }
    }

    /// Whether to show the dash lines.
    public var showDashedLines: Bool = false {
        didSet {
            cartesianPlane.showDashedLines = showDashedLines
        }
    }

    /// Whether to show the axes ticks.
    public var showTicks: Bool = true {
        didSet {
            cartesianPlane.showTicks = showTicks
            
            if let barPlotView = plotView as? FLBarPlotView {
                barPlotView.showTicks = showTicks
            }
        }
    }
    
    /// Whether to show the y-axis.
    public var showYAxis: Bool = true {
        didSet {
            cartesianPlane.yAxisPosition = showYAxis ? .left : .none
        }
    }

    /// Whether to show the x-axis.
    public var showXAxis: Bool = true {
        didSet {
            cartesianPlane.showXAxis = showXAxis
          (self.plotView as? FLBarPlotView)?.showXAxis = showXAxis
        }
    }

    /// The minimum value of the y axis.
    public var yMinValue: CGFloat = 0 {
        didSet {
            cartesianPlane.dataMinValue = yMinValue
            plotView.minPlotYValue = yMinValue
        }
    }
  
    /// The maximum value of the y axis.
    public var yMaxValue: CGFloat? {
        didSet {
            cartesianPlane.dataMaxValue = yMaxValue
            plotView.maxPlotYValue = yMaxValue
        }
    }

    public var config: FLChartConfig {
        didSet {
            cartesianPlane.config = config
            plotView.config = config
        }
    }
    
    /// The highlight view delegate that observes different states of the view.
    public weak var highlightingDelegate: ChartHighlightingDelegate? {
        didSet {
            plotView.highlightingDelegate = highlightingDelegate
        }
    }
    
    // MARK: - Inits
    
    public init(data: FLChartData, type: PlotType) {
        self.config = FLChartConfig()
        self.chartData = data
        self.title = data.title
        self.legendKeys = data.legendKeys
        self.formatter = data.yAxisFormatter
        var horizontalRepresentedValues = false
        self.plotView = {
            switch type {
            case .bar(let bar, let highlightView, let focusView, let barConfig):
                let barPlotView = FLBarPlotView(data: data, bar: bar, highlightView: highlightView, focusView: focusView)
                barPlotView.barConfig = barConfig
                horizontalRepresentedValues = bar.init().horizontalRepresentedValues
                return barPlotView
            }
        }()
        self.horizontalRepresentedValues = horizontalRepresentedValues
        self.cartesianPlane = FLCartesianPlane(data: data, type: type, horizontalRepresentedValues: horizontalRepresentedValues)

        super.init(frame: .zero)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        let data = FLChartData(title: "", data: [0], legendKeys: [], unitOfMeasure: "")
        self.chartData = data
        self.config = FLChartConfig()
        self.cartesianPlane = FLCartesianPlane(data: data, type: .bar(), horizontalRepresentedValues: false)
        self.plotView = FLBarPlotView(data: data)
        self.horizontalRepresentedValues = false
        super.init(coder: coder)
    }
    
    /// Sets up the chart from the storyboard.
    public func setup(data: FLChartData, type: PlotType) {
        self.config = FLChartConfig()
        self.chartData = data
        self.title = data.title
        self.legendKeys = data.legendKeys
        self.formatter = data.yAxisFormatter
        var horizontalRepresentedValues = false

        self.plotView = {
            switch type {
            case .bar(let bar, let highlightView, let focusView, let barConfig):
                let barPlotView = FLBarPlotView(data: data, bar: bar, highlightView: highlightView, focusView: focusView)
                barPlotView.barConfig = barConfig
                horizontalRepresentedValues = bar.init().horizontalRepresentedValues
                return barPlotView
            }
        }()
        self.horizontalRepresentedValues = horizontalRepresentedValues
        self.cartesianPlane = FLCartesianPlane(data: data, type: type, horizontalRepresentedValues: horizontalRepresentedValues)
                
        self.commonInit()
    }
    
    private func commonInit() {
      self.cartesianPlane.plotView = plotView
      self.cartesianPlane.didUpdateChartLayoutGuide = { layoutGuide in
        self.plotView.constraints(equalTo: layoutGuide, directions: .all)
      }
        
      addSubview(cartesianPlane)
      cartesianPlane.constraints(equalTo: self, directions: .all)
    }
    
    // MARK: - Methods
    
    public func updateChart(data: [PlotableData]) {
        chartData.dataEntries = data
        cartesianPlane.updateData(data)
        plotView.updateData(data)
    }
    
    internal static func canShowAverage(chartType: FLChart.PlotType, data: FLChartData, horizontalRepresentedValues: Bool) -> Bool {
        if horizontalRepresentedValues {
            return false
        }
        
        return true
    }
}
