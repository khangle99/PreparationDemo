//
//  BarHighlightedView.swift
//  FLCharts
//
//  Created by Francesco Leoni on 09/01/22.
//  Copyright © 2021 Francesco Leoni All rights reserved.
//

import UIKit

/// A simple highlighted view that displays the value of the currently highlighted chart bar.
public final class BarFocusView: UIView, HighlightedView {
    
    var arrowHeight: CGFloat = 15
    var arrowWidth: CGFloat = 30
    
    public var dataValue: String?
    
    private let dataValueLabel = UILabel()
    private let unitOfMeasureLabel = UILabel()
    
    private lazy var triagleLayer: CAShapeLayer = {
        let triagle = CAShapeLayer()
        triagle.fillColor = UIColor(red: 29/255, green: 27/255, blue: 55/255, alpha: 1).cgColor
        triagle.path = createRoundedTriangle(width: arrowWidth, height: arrowHeight, radius: 3)
        layer.addSublayer(triagle)
        return triagle
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        triagleLayer.position = CGPoint(x: bounds.width/2, y: bounds.height - arrowHeight)
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 29/255, green: 27/255, blue: 55/255, alpha: 1)
        layer.cornerRadius = 6.5
        dataValueLabel.text = "0"
        dataValueLabel.textColor = .white
        dataValueLabel.textAlignment = .right
        dataValueLabel.font = .preferredFont(for: .subheadline, weight: .bold)
        dataValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        unitOfMeasureLabel.textColor = .white
        unitOfMeasureLabel.textAlignment = .left
        unitOfMeasureLabel.font = .preferredFont(for: .footnote, weight: .medium)
        unitOfMeasureLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(dataValueLabel)
        NSLayoutConstraint.activate([
            dataValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dataValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dataValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        addSubview(unitOfMeasureLabel)
        NSLayoutConstraint.activate([
            unitOfMeasureLabel.leadingAnchor.constraint(equalTo: dataValueLabel.trailingAnchor, constant: 3),
            unitOfMeasureLabel.bottomAnchor.constraint(equalTo: dataValueLabel.bottomAnchor),
            unitOfMeasureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: 10 + dataValueLabel.intrinsicWidth + 5 + unitOfMeasureLabel.intrinsicWidth + 10,
               height: 10 + dataValueLabel.intrinsicHeight + 10)
    }
    
    public func update(with value: String?) {
        dataValueLabel.text = value
    }
    
    public func update(withChartData chartData: FLChartData?) {
        unitOfMeasureLabel.text = chartData?.yAxisUnitOfMeasure
    }
    
    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        // Draw the triangle path with its origin at the center.
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: 3 * height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()

        return path
    }
}
