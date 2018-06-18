//
//  RectButton.swift
//  MyTeletouch
//
//  Created by julian on 6/22/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class RectButton: UIControl {
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    @IBInspectable var fillInColor: UIColor = UIColor.whiteColor()
    @IBInspectable var drawLines: Bool = false
    
    var isDown: Bool = false {
        didSet {
            setNeedsDisplay()
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }

    
    override func drawRect(rect: CGRect) {
        
        if(drawLines)
        {
            // 1
            let pointL1Start = CGPoint(x: 0.0, y: 5.0)
            let pointL1End = CGPoint(x: 0.0, y: bounds.height-10.0)

            let pointL2Start = CGPoint(x:bounds.width, y: 5.0)
            let pointL2End = CGPoint(x:bounds.width, y: bounds.height-10.0)
        
            // 2
            var line1Path = UIBezierPath()
            line1Path.moveToPoint(pointL1Start)
            line1Path.addLineToPoint(pointL1End)
            line1Path.lineWidth = 2.0;
        

            var line2Path = UIBezierPath()
            line2Path.moveToPoint(pointL2Start)
            line2Path.addLineToPoint(pointL2End)
            line2Path.lineWidth = 2.0;
        
        
            // 3
            fillColor.setStroke()
            line1Path.stroke()
            line2Path.stroke()
        }
        
        if(isDown)
        {
            var fillPath = UIBezierPath(rect: bounds)
            fillInColor.setFill()
            fillPath.fill()
        }
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
