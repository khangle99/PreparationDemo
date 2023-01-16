//
//  CircularProgressView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 15/01/2023.
//

import UIKit

class CircularProgressView: UIView {
    
    // MARK: - Properties
    
    var currentProgress: CGFloat =  0.0
    
    var progressColor: UIColor = .blue {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    var circleColor: UIColor = .white {
        didSet {
            circleLayer.strokeColor = circleColor.cgColor
        }
    }
    
    var lineWidth: CGFloat = 20 {
        didSet {
            circleLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
        }
    }
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = self.bounds
        progressLayer.frame = self.bounds
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0), radius: bounds.size.width/2, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }

    

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    func createCircularPath() {
        // created circularPath for circleLayer and progressLayer
//        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        // circleLayer path defined to circularPath
        //circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = circleColor.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        //progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(to value: CGFloat,  duration: TimeInterval) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.fromValue = currentProgress
            circularProgressAnimation.toValue = value
            circularProgressAnimation.fillMode = .forwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
            currentProgress = value
        }
}
