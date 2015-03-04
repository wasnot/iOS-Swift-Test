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
//        resizeLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushButton(sender: AnyObject) {
        label.text = label.text! + "へえ";
    }
    @IBAction func unwindToTop(segue:UIStoryboardSegue )    {
    }
    
    func resizeLabel(){
        // --- テキストの内容によりラベルの大きさを変える ---
        // 表示最大サイズ
        var bounds:CGSize = CGSizeMake(label.frame.size.width, 200);
        // フォント
        var font:UIFont = label.font;
        // 表示モード
        var mode:NSLineBreakMode = label.lineBreakMode;
        // 文字列全体のサイズを取得
        var size:CGSize = label.frame.size;
        println("size:" + "\(size)");

        if(label.text != nil){
            size = font.sizeOfString(label.text!, constrainedToWidth: Double(bounds.width) );
            println("size:" + "\(size)");
        }
//        size.width  = ceilf(size.width);
//        size.height = ceilf(size.height);
//        NSLog(@"size: %@", NSStringFromCGSize(size));
        println("size:" + "\(size)");
        
        // ラベルのサイズを変更
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, size.height);
    }
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRectWithSize(CGSize(width: width, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
}


