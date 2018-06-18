//
//  MouseViewController.swift
//  MyTeletouch
//
//  Created by julian on 5/26/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class MouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainController.activeViewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    @IBAction func RingChanged(sender: RingControl) {
        mainController.mousePosition = sender.offset
        if(sender.isTapped) {
            mainController.isMouseLeftDown = true;
            mainController.isMouseLeftDown = false;
        }
    }
    
    @IBAction func LeftButtonChanged(sender: RectButton) {
        mainController.isMouseLeftDown = sender.isDown
    }
    
    @IBAction func MiddleButtonChanged(sender: RectButton) {
        mainController.isMouseMiddleDown = sender.isDown
    }
    
    @IBAction func RightButtonChanged(sender: RectButton) {
        mainController.isMouseRightDown = sender.isDown
    }
}

