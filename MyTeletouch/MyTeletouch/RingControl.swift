//
//  RingControl.swift
//  MyTeletouch
//
//  Created by julian on 6/1/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class RingControl: UIControl {
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    @IBInspectable var fillInColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var isMouse: Bool = true
   
    var offset: CGPoint = CGPoint() {
        didSet {
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }

    var visualOffset: CGPoint = CGPoint() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var isTapped: Bool = false {
        didSet {
            self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
    
    var startLocation = CGPoint()
    var previousLocation = CGPoint()
    var isDown: Bool = false
    var timeStart : NSTimeInterval = 0
    var timeLast : NSTimeInterval = 0

    override func drawRect(rect: CGRect) {
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let centerIn = CGPoint(x:center.x+visualOffset.x, y: center.y+visualOffset.y)
       
        // 2
        let radius: CGFloat = min(bounds.width, bounds.height) / 1.5
        let radiusIn: CGFloat = min(bounds.width, bounds.height) / 4

        // 3
        let arcWidth: CGFloat = 3
        let arcWidthIn: CGFloat = 30

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
        fillInColor.setFill()
        path.fill()
        path.lineWidth = arcWidth
        pathIn.lineWidth = arcWidthIn
        fillColor.setStroke()
        path.stroke()
        pathIn.stroke()
    }
    
    /**
    Hanles touches begin
    
    :param: touches Touches list
    :param: event Event information
    */
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            isDown = true
            timeStart = NSDate().timeIntervalSince1970
            timeLast = timeStart
            if(isMouse){
                startLocation = touch.locationInView(self)
                previousLocation = startLocation
            } else {
                startLocation = CGPoint(x:bounds.width/2, y: bounds.height/2)
                previousLocation = startLocation
                handleMoved(touch.locationInView(self), forceMove: true)
            }
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(isDown)
        {
            var aTouch = touches.first as? UITouch
            var location = aTouch!.locationInView(self)
            handleMoved(location, forceMove: false)
        }
        super.touchesMoved(touches , withEvent:event)
    }
    
    /**
    Hanlde moved
    
    :param: location Position in control
    */
    private func handleMoved(location: CGPoint, forceMove: Bool) {
        var newOffset = CGPoint()
        
        if(isMouse) {
            var factor: CGFloat = 2
            //var timeSinceStartExecutionMs = abs(NSDate().timeIntervalSince1970 - timeStart) * 1000
            //if(timeSinceStartExecutionMs > 400) {
            //    factor = 2
            //}
            
            newOffset.x = min(max((location.x - previousLocation.x) * factor, -127), 127)
            newOffset.y = min(max((location.y - previousLocation.y) * factor, -127), 127)
        } else {
            newOffset.x = min(max(location.x - startLocation.x, -127), 127)
            newOffset.y = min(max(location.y - startLocation.y, -127), 127)
        }
        
        var timeSinceLastExecutionMs = abs(NSDate().timeIntervalSince1970 - timeLast) * 1000
        var needToUpdate = forceMove || ((timeSinceLastExecutionMs > 20) &&
                        (abs(offset.x - newOffset.x) >= 1.0 || abs(offset.y - newOffset.y) >= 1.0))
        
        if(needToUpdate) {
            var newVisualOffset = CGPoint()
            newVisualOffset.x = min(max(newOffset.x, -10), 10)
            newVisualOffset.y = min(max(newOffset.y, -10), 10)
            
            visualOffset = newVisualOffset
            offset = newOffset
            
            previousLocation = location
            timeLast = NSDate().timeIntervalSince1970
        }
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
        if(isDown)
        {
            isDown = false
            
            var aTouch = touches.first as? UITouch
            var location = aTouch!.locationInView(self)
            var timeSinceStartExecutionMs = abs(NSDate().timeIntervalSince1970 - timeStart) * 1000
            var isMouseTap = isMouse && (offset.x < 5 && offset.y < 5 &&
                timeSinceStartExecutionMs < 500)
            
            NSThread.sleepForTimeInterval(0.05);
            
            offset = CGPoint()
            visualOffset = CGPoint()

            if (isMouseTap) {
                isTapped = true
                isTapped = false
            }
        }
    }
}
