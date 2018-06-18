//
//  RingButton.swift
//  MyTeletouch
//
//  Created by julian on 6/1/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class RingButton: UIControl {
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    @IBInspectable var fillInColor: UIColor = UIColor.whiteColor()
    @IBInspectable var fillInnerColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)

    var isDown: Bool = false {
        didSet {
            setNeedsDisplay()
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }

    
    override func drawRect(rect: CGRect) {
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let centerIn = CGPoint(x:center.x, y: center.y)
        
        // 2
        let radius: CGFloat = min(bounds.width, bounds.height) - 10
        let radiusIn: CGFloat = radius / 2.8
        
        // 3
        let arcWidth: CGFloat = radius / 23.33
        let arcWidthIn: CGFloat = radius / 14.0
        
        // 4
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = CGFloat(2 * M_PI)
        
        // 5
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        var pathIn = UIBezierPath(arcCenter: centerIn,
            radius: radiusIn/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 6
        if(isDown){
            fillColor.setFill()
        }
        else{
            fillInnerColor.setFill()
        }
        path.fill()
        path.lineWidth = arcWidth
        pathIn.lineWidth = arcWidthIn
        fillColor.setStroke()
        path.stroke()
        fillInColor.setStroke()
        pathIn.stroke()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("touchesBegan")
        if let touch = touches.first as? UITouch {
            isDown = true
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchesEndedOrCanceled(touches, withEvent: event)
        super.touchesEnded(touches , withEvent:event)
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        touchesEndedOrCanceled(touches, withEvent: event)
        super.touchesCancelled(touches , withEvent:event)
    }
    
    func touchesEndedOrCanceled(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("touchesEndedOrCanceled")
        if(isDown)
        {
            NSThread.sleepForTimeInterval(0.05);
            isDown = false
        }
    }
}
