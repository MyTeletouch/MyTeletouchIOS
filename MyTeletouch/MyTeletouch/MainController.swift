//
//  MainController.swift
//  MyTeletouch
//
//  Created by julian on 5/27/15.
//  Copyright (c) 2015 MyTeletouch. All rights reserved.
//

import UIKit
import CoreBluetooth

var mainController : MainController = MainController()

struct DeviceCommand{
    var id  = Int()
    var data = [UInt8]()
    var responseRequired  = false
}

class MainController: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var commands = Queue<DeviceCommand>()
    var lastCommandId : Int = 0
    
    var activeCentralManager: CBCentralManager?
    var peripheralDevice: CBPeripheral?
    var devices: Dictionary<String, CBPeripheral> = [:]
    var deviceName: String?
    var devicesRSSI = [NSNumber]()
    var devicesServices: CBService!
    var deviceCharacteristics: CBCharacteristic!
    var activeViewController: UIViewController?
    
    
    var mousePosition : CGPoint = CGPoint() { didSet { sendMouseData() } }
    var isMouseLeftDown : Bool = false { didSet { sendMouseData() } }
    var isMouseMiddleDown : Bool = false { didSet { sendMouseData() } }
    var isMouseRightDown : Bool = false { didSet { sendMouseData() } }
    
    var joystickPosition : CGPoint = CGPoint() { didSet { sendJoystickData() } }
    var isJoystick1Down : Bool = false { didSet { sendJoystickData() } }
    var isJoystick2Down : Bool = false { didSet { sendJoystickData() } }
    var isJoystick3Down : Bool = false { didSet { sendJoystickData() } }
    var isJoystick4Down : Bool = false { didSet { sendJoystickData() } }
    var isJoystick5Down : Bool = false { didSet { sendJoystickData() } }
    

    var keys = [UInt8](count: 3, repeatedValue: 0) { didSet { sendKeyboardData() } }
    
    
    private func sendMouseData(){
        var buttons = getMouseButtons()
       
        var data : [UInt8] = [
            2,
            buttons,
            UInt8(mousePosition.x),
            UInt8(mousePosition.y)
        ]
        
        sendCommand(data)
    }

    private func getMouseButtons()-> UInt8{
        var res : UInt8 = 0x00000000
        
        if(isMouseLeftDown){
            res |= 0x01											/* If pressed, mask bit to indicate button press */
        }
        
        if(isMouseRightDown){
            res |= 0x02											/* If pressed, mask bit to indicate button press */
        }
        
        if(isMouseMiddleDown){
            res |= 0x04											/* If pressed, mask bit to indicate button press */
        }
        
        return res;
    }
    
    private func sendKeyboardData(){
        var data : [UInt8] = [
            1,
            keys[0],
            keys[1],
            keys[2]
        ]
        
        sendCommand(data)
    }

    private func sendJoystickData(){
        var buttons = getJoystickButtons()
        
        var data : [UInt8] = [
            3,
            UInt8(127 + joystickPosition.x),
            UInt8(127 + joystickPosition.y),
            buttons
        ]
        
        sendCommand(data)
    }

    private func getJoystickButtons()-> UInt8{
        var res : UInt8 = 0x00000000
        
        if(isJoystick1Down){
            res |= 0x01											/* If pressed, mask bit to indicate button press */
        }
        
        if(isJoystick2Down){
            res |= 0x02											/* If pressed, mask bit to indicate button press */
        }
        
        if(isJoystick3Down){
            res |= 0x04											/* If pressed, mask bit to indicate button press */
        }

        if(isJoystick4Down){
            res |= 0x08											/* If pressed, mask bit to indicate button press */
        }

        if(isJoystick5Down){
            res |= 0x10											/* If pressed, mask bit to indicate button press */
        }
        
        return res;
    }
    
    private func sendCommand(commandData: [UInt8]){
        lastCommandId++;
        if (lastCommandId > 255){
            lastCommandId = 0
        }
    
        var sbCmd : StringBuilder = StringBuilder()
        sbCmd.append(String(format: "%d", Int(commandData[0])))
        sbCmd.append(String(format: "|%d", lastCommandId))
        var i: Int = 1
        for (i = 1; i < commandData.count; i++) {
            if(commandData[i] == 0 ){
                sbCmd.append("|0")
            }else {
                sbCmd.append(NSString(format: "|%02X", commandData[i]))
            }
        }
        sbCmd.append(String(format: "|%d]", lastCommandId))
        writeValue(sbCmd.toString())
    }
    
    func update(){
        // Clear devices dictionary.
        devices.removeAll(keepCapacity: false)
        devicesRSSI.removeAll(keepCapacity: false)
        // Initialize central manager on load
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        //self.refreshControl?.endRefreshing()
    }
    
    // MARK: BLE
    func centralManagerDidUpdateState(central: CBCentralManager?) {
        if let central = central{
            if central.state == CBCentralManagerState.PoweredOn {
                // Scan for peripherals if BLE is turned on
                central.scanForPeripheralsWithServices(nil, options: nil)
                println("Searching for BLE Devices")
            }
            else {
                // Can have different conditions for all states if needed - print generic message for now
                println("Bluetooth switched off or not initialized")
            }
        }
        
    }
    
    // Check out the discovered peripherals to find Sensor Tag
    func centralManager(central: CBCentralManager?, didDiscoverPeripheral peripheral: CBPeripheral?, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        if let central = central{
            if let peripheral = peripheral{
                // Get this device's UUID.
                if let name = peripheral.name{
                    if(name == "MyTeletouch" && devices[name] == nil){
                        devices[name] = peripheral
                        devicesRSSI.append(RSSI)
                        if let connectController = activeViewController as? ConnectViewController {
                            connectController.tableView.reloadData()
                        }
                    }
                    
                }
            }
        }
    }
    
    // Discover services of the peripheral
    func centralManager(central: CBCentralManager?, didConnectPeripheral peripheral: CBPeripheral?) {
        
        if let central = central{
            if let peripheral = peripheral{
                // Discover services for the device.
                if let peripheralDevice = peripheralDevice{
                    peripheralDevice.discoverServices(nil)
                    //if let navigationController = navigationController{
                    //    navigationItem.title = "Connected to \(deviceName)"
                    //}
                }
            }
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral?, didDiscoverServices error: NSError!) {
        
        if let peripheral = peripheral{
            // Iterate through the services of a particular peripheral.
            for service in peripheral.services {
                let thisService = service as? CBService
                // Let's see what characteristics this service has.
                if let thisService = thisService{
                    peripheral.discoverCharacteristics(nil, forService: thisService)
                    //if let navigationController = navigationController{
                    //    navigationItem.title = "Discovered Service for \(deviceName)"
                    //}
                }
            }
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral?, didDiscoverCharacteristicsForService service: CBService?, error: NSError?) {
        
        if let peripheral = peripheral{
            
            if let service = service{
                // check the uuid of each characteristic to find config and data characteristics
                for charateristic in service.characteristics {
                    let thisCharacteristic = charateristic as! CBCharacteristic
                    // Set notify for characteristics here.
                    peripheral.setNotifyValue(true, forCharacteristic: thisCharacteristic)
                    
                    //if let navigationController = navigationController{
                    //    navigationItem.title = "Discovered Characteristic for \(deviceName)"
                    //}
                    deviceCharacteristics = thisCharacteristic
                }
                
                // Now that we are setup, return to main view.
                //if let navigationController = navigationController{
                //    navigationController.popViewControllerAnimated(true)
                //}
            }
        }
    }
    
    // Get data values when they are updated
    func peripheral(peripheral: CBPeripheral?, didUpdateValueForCharacteristic characteristic: CBCharacteristic?, error: NSError!) {
        println("Got some!")
    }
    
    func cancelConnection(){
        if let activeCentralManager = activeCentralManager{
            println("Died!")
            if let peripheralDevice = peripheralDevice{
                //println(peripheralDevice)
                activeCentralManager.cancelPeripheralConnection(peripheralDevice)
            }
        }
    }
    
    // If disconnected, start searching again
    func centralManager(central: CBCentralManager?, didDisconnectPeripheral peripheral: CBPeripheral?, error: NSError?) {
        if let central = central{
            if let peripheral = peripheral{
                println("Disconnected")
                central.scanForPeripheralsWithServices(nil, options: nil)
            }
        }
    }
    
    func writeValue(data: String){
        //println("writeValue:")
        //println(data)
        let data = (data as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        if let peripheralDevice = peripheralDevice{
            if let deviceCharacteristics = deviceCharacteristics{
                peripheralDevice.writeValue(data, forCharacteristic: deviceCharacteristics, type: CBCharacteristicWriteType.WithoutResponse)
            }
        }
    }
}
