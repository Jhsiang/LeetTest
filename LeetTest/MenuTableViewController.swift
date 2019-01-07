//
//  MenuTableViewController.swift
//  LeetTest
//
//  Created by Jim Chuang on 2019/1/4.
//  Copyright © 2019 jj. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menuDic:Dictionary<String,String> = ["廣告畫面":"seque_menu_to_demoParking",
                                             "數獨":"seque_menu_to_unitNumber",
                                             "相機存base64":"seque_menu_to_takePhoto",
                                             "collection手勢移動":"seque_menu_to_collectionGesture",
                                             "測試迴圈":"seque_menu_to_testLag",
                                             "圖像3d旋轉":"seque_menu_to_imageRotation",
                                             "題目邏輯":"seque_menu_to_leetTest",
                                             "picker測試":"seque_menu_to_pickTest"]

    var keyArr = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        keyArr.removeAll()
        for key in menuDic.keys{
            keyArr.append(key)
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuDic.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_menu", for: indexPath)
        cell.textLabel?.text = keyArr[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyStr = keyArr[indexPath.row]
        if let sequeStr = menuDic[keyStr]{
            self.performSegue(withIdentifier: sequeStr, sender: self)
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
