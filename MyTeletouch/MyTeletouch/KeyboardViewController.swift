//
//  KeyboardViewController.swift
//  MyTeletouch
//
//  Created by julian on 5/27/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dummyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainController.activeViewController = self
        self.dummyText.autocapitalizationType = UITextAutocapitalizationType.None
        self.dummyText.autocorrectionType = UITextAutocorrectionType.No
        self.dummyText.becomeFirstResponder()
        self.dummyText.delegate = self
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
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
      
        if(text.isEmpty){
            processScanCode(AnsiiToScanCodeConverter.scanCode(8))
        }
        else {
            for character in text {
                processScanCode(AnsiiToScanCodeConverter.scanCodeFromChar(character))
            }
        }
        
        return true
    }
    
    /**
    Handle down and up on every character
    
    :param: info character info as scan code and shift state
    */
    func processScanCode(info: ScanCodeInfo) {
        var keysEmpty = [UInt8](count: 3, repeatedValue: 0)
        
        var keys = [UInt8](count: 3, repeatedValue: 0)
        keys[0] = info.SpecialKeys
        keys[2] = info.ScanCode
        
        mainController.keys = keys
        NSThread.sleepForTimeInterval(0.05);
        mainController.keys = keysEmpty
    }
    
}
