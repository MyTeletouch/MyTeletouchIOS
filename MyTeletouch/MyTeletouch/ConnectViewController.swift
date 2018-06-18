//
//  ConnectViewController.swift
//  MyTeletouch
//
//  Created by julian on 5/26/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonConnect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainController.activeViewController = self
        mainController.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshTouchUp(sender: AnyObject) {
        mainController.update()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainController.devices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        // Turn the device dictionary into an array.
        let discoveredPeripheralArray = mainController.devices.keys.array
        cell.textLabel?.text = discoveredPeripheralArray[indexPath.row]
        cell.detailTextLabel?.text = mainController.devices.values.array[indexPath.row].identifier.UUIDString
        cell.backgroundColor = nil
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (mainController.devices.count > 0){
            // Get an array of peripherals.
            let discoveredPeripheralArray = mainController.devices.values.array
            
            // Set the peripheralDevice to the corresponding row selected.
            mainController.peripheralDevice = discoveredPeripheralArray[indexPath.row]
            
            // Attach the peripheral delegate.
            if let peripheralDevice = mainController.peripheralDevice{
                peripheralDevice.delegate = mainController
                mainController.deviceName = peripheralDevice.name!
                buttonConnect.hidden = false
            }
            else
            {
                mainController.deviceName = " "
            }
            
            if let activeCentralManager = mainController.activeCentralManager{
                // Stop looking for more peripherals.
                activeCentralManager.stopScan()
                // Connect to this peripheral.
                activeCentralManager.connectPeripheral(mainController.peripheralDevice, options: nil)
                //if let navigationController = navigationController{
                //    navigationItem.title = "Connecting \(deviceName)"
                //}
            }
        }
    }
}

