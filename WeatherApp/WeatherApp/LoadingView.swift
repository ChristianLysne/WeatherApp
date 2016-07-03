//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Christian Lysne on 03/07/16.
//  Copyright © 2016 Christian Lysne. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    var innerArcLayer: CAShapeLayer!
    var outerArcLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        innerArcLayer = CAShapeLayer()
        styleArcLayer(innerArcLayer)
        self.layer.addSublayer(innerArcLayer)
        
        outerArcLayer = CAShapeLayer()
        styleArcLayer(outerArcLayer)
        self.layer.addSublayer(outerArcLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateArc(innerArcLayer, radius: self.frame.width/3)
        self.updateArc(outerArcLayer, radius: self.frame.width/2)
    }
    
    func startAnimating() {
        startAnimatingLayer(outerArcLayer, clockwise: true)
        startAnimatingLayer(innerArcLayer, clockwise: false)
    }
    
    func stopAnimating() {
        stopAnimatingLayer(outerArcLayer)
        stopAnimatingLayer(innerArcLayer)
    }
    
    private func startAnimatingLayer(layer: CAShapeLayer, clockwise: Bool) {
        if layer.animationForKey("LoadingAnimation") == nil {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = NSNumber(float: clockwise ? 0 : 2 * Float(M_PI))
            animation.toValue = NSNumber(float: clockwise ? 2 * Float(M_PI) : 0)
            animation.duration = 3.0
            animation.repeatCount = .infinity
            animation.removedOnCompletion = false
            layer.addAnimation(animation, forKey: "LoadingAnimation")
        }
    }
    
    private func stopAnimatingLayer(layer: CAShapeLayer) {
        layer.removeAllAnimations()
    }
    
    private func styleArcLayer(layer: CAShapeLayer) {
        layer.lineWidth = 2
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeColor = Constants.Colors.TodaysWeatherInfo.CGColor
    }
    
    private func updateArc(arc: CAShapeLayer, radius: CGFloat) {
        let path = UIBezierPath(arcCenter: self.center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat(1.8 * M_PI),
                                clockwise: true)
        arc.path = path.CGPath
        
        let arcRect = CGPathGetBoundingBox(arc.path)
        arc.bounds = arcRect
        let offset = (self.frame.width - arcRect.width)/2
        arc.position = CGPointMake(arcRect.size.width * 0.5 + offset, arcRect.size.height * 0.5 + offset)
    }
}