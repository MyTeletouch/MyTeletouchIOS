//
//  CustomKeyboardViewController.swift
//  MyTeletouch
//
//  Created by julian on 7/22/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//


import UIKit

class CustomKeyboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainController.activeViewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }
    
    /**
    Handle down and up on every character
    
    :param: info character info as scan code and shift state
    */
    func processScanCode(info: ScanCodeInfo) {
        var keysEmpty = [UInt8](count: 8, repeatedValue: 0)
        
        var keys = [UInt8](count: 8, repeatedValue: 0)
        keys[0] = info.SpecialKeys
        keys[2] = info.ScanCode
        
        mainController.keys = keys
        
        mainController.keys = keysEmpty
    }
    
}