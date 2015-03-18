//
//  SettingTableViewController.swift
//  WifiWidget
//
//  Created by AidaAkihiro on 2015/03/13.
//  Copyright (c) 2015年 Wasnot Apps. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController  {
    let DEFAULT_SUITE = "group.net.wasnot.ios.wifiwidget";
    let KEY_DISPLAY_SSID = "displaySSID";
    let KEY_DISPLAY_MAC = "displayMacAddress";
    
    //セルタップ時のアクションを分岐させる為の定数(CellのTagに設定する)
    let PROFILE_NAME    = 1
    let PROFILE_JOB     = 2
    let NO_ACTION       = 0//Switchの付いたセル用
    
    //スイッチのアクションを分岐させる為の定数(UISwitchのTagに設定する)
    let SWITCH_SSID       = 1
    let SWITCH_MAC        = 2
    
    @IBOutlet weak var SettingTitle: UINavigationItem!

    @IBOutlet var SettingTable: UITableView!
    @IBAction func pushBackButton(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //DB関連のヒント
        //ここでSQL(SELECT文)を使ってセクション(設定のカテゴリ)のタイトルを取得して"return"する
        //当メソッド引数の"section(0から始まるセクション番号)"をWHERE句に使う
        
        var str_SectionTitle : String? ;
    
        switch (section) {
        case 0://第1セクション
            str_SectionTitle = NSLocalizedString("LABEL_SETTING_SEC_APP", comment: "About app");
            break;
        case 1://第2セクション
            str_SectionTitle = NSLocalizedString("LABEL_SETTING_SEC_DISPLAY", comment: "Display settings");
            break;
        default:
            break;
        }
        
        return str_SectionTitle;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //DB関連のヒント
        //ここでSQL(SELECT文)を使って各セクション毎のセル(設定項目)の数を取得して"return"する
        //当メソッド引数の"section(0から始まるセクション番号)"をWHERE句に使う
        
        var int_CellCount : Int = 0;
        
        switch (section) {
        case 0://第1セクション
            int_CellCount = 1;
            break;
        case 1://第2セクション
            int_CellCount = 2;
            break;
        default:
            break;
        }
        
        return int_CellCount;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        //DB関連のヒント
        //ここでSQL(SELECT文)を使って各セクション毎の各セル(設定項目)の設定をしてCellオブジェクトを"return"する
        //当メソッド引数の"indexPath"のプロパティをWHERE句に使う
        // セクション番号:indexPath.section
        // セル番号　　　:indexPath.row
        // どちらも0始まり
        //DBには以下データなどを持っておくと良い
        // セルタイトル　　:cell.textLabel.text
        // セル詳細タイトル:cell.detailTextLabel.text
        // セル判別用タグ　:cell.tag
        // セルアイテム　　:cell.accessoryType
        // セル画像　　　　:cell.imageView.image
        // セルタップ許容　:cell.userInteractionEnabled
        //このチュートリアルでは、分かりやすくする為に以下Switch文を使ったベタ書きだが、
        //DBからデータを抽出して、可変設定とするのが望ましい
        
        let CellIdentifier = "Cell";
        let cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell;
        
        var str_CellTitle :String = "";        //セルタイトル
        var str_CellTitleDetail :String = "";  //セル詳細タイトル
        
        let switchObj :UISwitch = UISwitch(frame: CGRectMake(1.0, 1.0, 20.0, 20.0));//スイッチ
        
        //各セクション各セル毎に表示内容の設定を分岐させる
        switch (indexPath.section) {
        case 0://第1セクション
            switch (indexPath.row) {
            case 0://第1セル
                str_CellTitle       = NSLocalizedString("LABEL_SETTING_APP_APP_VERSION", comment: "App version");
                let version: String! = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as String
                str_CellTitleDetail = version;
                cell.tag = PROFILE_NAME;//セルタップ時アクション分岐用
                cell.accessoryType = UITableViewCellAccessoryType.None;//セルアイテム無し
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                break;
                
            case 1://第2セル
                str_CellTitle       = "ジョブ";
                str_CellTitleDetail = "勇者";
                cell.tag = PROFILE_JOB;//セルタップ時アクション分岐用
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;//「詳細画面へ」アイテム
                
                break;
            default:
                break;
            }
            break;
            
        case 1://第2セクション
            switch (indexPath.row) {
            case 0://第1セル
                str_CellTitle       = NSLocalizedString("LABEL_SETTING_DISPLAY_SSID", comment: "Spot name (SSID)");
                str_CellTitleDetail = "";
                cell.tag = NO_ACTION;//セルタップ時アクション分岐用
                
                //UISwitchのみタッチ可に見せかける
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                
                let sharedUserDefaults : NSUserDefaults? = NSUserDefaults(suiteName: DEFAULT_SUITE);
                var displaySSID : Bool;
                if(sharedUserDefaults != nil && sharedUserDefaults!.objectForKey(KEY_DISPLAY_SSID) != nil){
                    displaySSID = sharedUserDefaults!.boolForKey(KEY_DISPLAY_SSID)
                }else{
                    displaySSID = true;
                }
                
                //スイッチの配置
                switchObj.on = displaySSID;//スイッチの状態（ONかOFF）
                switchObj.tag = SWITCH_SSID; //複数スイッチの判別用
                switchObj.addTarget(self, action: "settingSwitch:", forControlEvents: UIControlEvents.ValueChanged);//スイッチタッチ時メソッドの設定
                cell.accessoryView = switchObj;
                break;
                
            case 1://第2セル
                str_CellTitle       = NSLocalizedString("LABEL_SETTING_DISPLAY_MAC", comment: "Mac address");
                str_CellTitleDetail = "";
                cell.tag = NO_ACTION;//セルタップ時アクション分岐用
                
                //UISwitchのみタッチ可に見せかける
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                
                let sharedUserDefaults : NSUserDefaults? = NSUserDefaults(suiteName: DEFAULT_SUITE);
                var displayMac : Bool;
                if(sharedUserDefaults != nil && sharedUserDefaults!.objectForKey(KEY_DISPLAY_MAC) != nil){
                    displayMac = sharedUserDefaults!.boolForKey(KEY_DISPLAY_MAC)
                }else{
                    displayMac = false;
                }

                //スイッチの配置
                switchObj.on = displayMac;//スイッチの状態（ONかOFF）
                switchObj.tag = SWITCH_MAC; //複数スイッチの判別用
                switchObj.addTarget(self, action: "settingSwitch:", forControlEvents: UIControlEvents.ValueChanged);//スイッチタッチ時メソッドの設定
                cell.accessoryView = switchObj;
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }
        
        cell.textLabel?.text       = str_CellTitle;
        cell.detailTextLabel?.text = str_CellTitleDetail;
        
        //    //セル画像(セル左端に画像を挿入したければこのコードを各セル毎に設定)
        //    cell.imageView.image = [UIImage imageNamed:@"ImageName"];
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        ConfigDetailVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfigDetailVC"];
        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
        
        //タップセル取得
        var tbc_Cell :UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!;
        
        //セルに設定されたタグに応じてアクションを分岐する
        switch (tbc_Cell.tag) {
        case PROFILE_NAME://名前変更
            NSLog("名前セルをタップしました");
            
            // この先の処理はお任せします
            // UITextField付きのUIAlertViewを表示させて
            // 入力された文字をDBへ反映させる感じでしょうか
            // 変更後は、UITableViewのリロードを忘れずに
            // （リロードしないと一旦別の画面に遷移してから
            // 帰って来ないと、変更が反映されません）
            // リロード例）[tbv_ConfigList reloadData];
            
            //UITextField付きのアラート表示例
//            [self alertTextField:self title:"名前変更" message:"ボタン押しても何も起きません" tag:0 btnYes:"決定" btnNo:"キャンセル"];
            
            break;
            
        case PROFILE_JOB://ジョブ選択画面に遷移
            NSLog("ジョブセルをタップしました");
            
//            VC.str_ConfigDetailTitle = tbc_Cell.textLabel.text;//セルのテキストを遷移先に渡す
//            [self presentModalViewController:VC animated:YES];
            break;
            
        case NO_ACTION://サウンドの設定はセルタップアクション無し
            break;
        default:
            break;
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    //--------------------------------
    // MARK: - UISwitchタッチ時アクション
    //--------------------------------
    func settingSwitch(sender : UISwitch ) {
        //スイッチに設定されたタグに応じてアクションを分岐する
        switch (sender.tag) {
        case SWITCH_SSID:
            NSLog("SSIDを %@ に変更しました", sender.on ? "ON" : "OFF");
            //この先の処理はお任せします
            //「sender.on」で変更後が「ONかOFF」を判別できます
            //その値をDBに反映させる感じでしょうか
            let sharedUserDefaults : NSUserDefaults? = NSUserDefaults(suiteName: DEFAULT_SUITE);
            if(sharedUserDefaults != nil){
                sharedUserDefaults!.setBool(sender.on, forKey: KEY_DISPLAY_SSID);
            }
            break;
        case SWITCH_MAC:
            NSLog("Macを %@ に変更しました", sender.on ? "ON" : "OFF");
            //同上
            let sharedUserDefaults : NSUserDefaults? = NSUserDefaults(suiteName: DEFAULT_SUITE);
            if(sharedUserDefaults != nil){
                sharedUserDefaults!.setBool(sender.on, forKey: KEY_DISPLAY_MAC);
            }
            break;
        default:
            break;
        }
    }
    
}
