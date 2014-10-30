//
//  ViewController.swift
//  SwiftTest
//
//  Created by AidaAkihiro on 2014/10/23.
//  Copyright (c) 2014年 Wasnot Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushButton(sender: AnyObject) {
        label.text = label.text! + "へえ";
    }
}

