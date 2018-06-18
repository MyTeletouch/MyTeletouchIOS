//
//  JoystickViewController.swift
//  MyTeletouch
//
//  Created by julian on 5/27/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class JoystickViewController: UIViewController {

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
        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }
   
    @IBAction func RingChanged(sender: RingControl) {
        mainController.joystickPosition = sender.offset
    }
    
    @IBAction func Button1Changed(sender: RingButton) {
        mainController.isJoystick1Down = sender.isDown
    }
    
    @IBAction func Button2Changed(sender: RingButton) {
        mainController.isJoystick2Down = sender.isDown
    }
    
    @IBAction func Button3Changed(sender: RingButton) {
        mainController.isJoystick3Down = sender.isDown
    }
    
    @IBAction func Button4Changed(sender: RingButton) {
        mainController.isJoystick4Down = sender.isDown
    }
    
    @IBAction func Button5Changed(sender: RingButton) {
        mainController.isJoystick5Down = sender.isDown
    }
}
