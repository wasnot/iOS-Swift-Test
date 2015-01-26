//
//  TodayViewController.swift
//  SwiftWidgetTest
//
//  Created by AidaAkihiro on 2014/10/23.
//  Copyright (c) 2014年 Wasnot Apps. All rights reserved.
//

import UIKit
import NotificationCenter
import SystemConfiguration

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateLabel()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        //        completionHandler(NCUpdateResult.NewData)
        println("widget update")
        
        self.updateLabel()
        completionHandler(NCUpdateResult.NewData)
    }
    
    func updateLabel()
    {
        println("widget update")
        
        //        var dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        //        self.label.text = dateFormatter.stringFromDate(NSDate())
        
        var success = false
        
        // 3G接続の場合はnilが戻されるので、以降のコードで注意する。
        //        CFArrayRef
        var interfaceOpt = CNCopySupportedInterfaces()
        if(interfaceOpt==nil){
            self.label.text = NSLocalizedString("LABEL_NO_WIFI", comment: "Wi-Fi disable")
            //"interface nil"
            success = true
        }else{
            var interface : Array = interfaceOpt!.takeRetainedValue()
            if(interface.count>0){
                //            var intArray : Array = interface.takeRetainedValue()
                var value : String = interface[0] as String
                println("value:"+value)
                
                //        CFDictionaryRef
                println("dicRef,")
                var dicRef = CNCopyCurrentNetworkInfo(value)
                //            println(dicRef)
                if(dicRef==nil){
                    self.label.text = NSLocalizedString("LABEL_NO_CONNECT", comment: "Not connected")
//                    self.label.text = "network infoない"
                    success = true
                }else{
                    println("dic,")
                    var dic : Dictionary = dicRef.takeRetainedValue()
                    println(dic)
                    
                    if(dic.count>0){
                        println(dic.count)
                        var ssid : String? = dic[kCNNetworkInfoKeySSID] as? String
                        if(ssid != nil){
                            println(ssid)
                            self.label.text = ssid
                            success = true
                        } else {
                            self.label.text = NSLocalizedString("LABEL_NO_SSID", comment: "Unknown")
//                            self.label.text = "ssidない"
                            success = true
                        }
                        //        var dicRef = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interface, 0) as CFStringRef);
                        
                        //        if (dicRef) {
                        //            ssid = CFDictionaryGetValue(dicRef, kCNNetworkInfoKeySSID);
                        // Macアドレスを取得
                        //macAddress = CFDictionaryGetValue(dicRef, kCNNetworkInfoKeyBSSID);
                        
                        //            NSLog(@"%@", ssid);
                        //        }
                    }else{
                        self.label.text = NSLocalizedString("LABEL_NO_CONNECT", comment: "Not connected")
//                        self.label.text = "wifiつながってない"
                        success = true
                    }
                }
            }else{
                self.label.text = NSLocalizedString("LABEL_NO_WIFI", comment: "Wi-Fi disable")
//                self.label.text = "interfaceない"
                success = true
            }
        }
        
        if(!success){
            //            self.label.text = dateFormatter.stringFromDate(NSDate())
            self.label.text = NSLocalizedString("LABEL_LOADING", comment: "Loading...")
//            self.label.text = "確認中"
        }
    }
    
    @IBAction func buttonTouched(sender: AnyObject) {
        self.updateLabel()
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left, bottom: 0, right: defaultMarginInsets.right)
    }
}
