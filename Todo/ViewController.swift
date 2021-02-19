//
//  ViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table: UITableView!
    
    var memoArray = [String]()
    
    var dateArray = [String]()
    
    let userDefaults = UserDefaults.standard
    
    var addContext: String!
    var addDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        
        table.delegate = self
        
        memoArray = ["明るい朝", "異色な人たち"]
        dateArray = ["　", "　"]
        
        //もし今までにデータ保存してたら
        ///初回保存はまだ保存されてないからこれ起動しないよ！ちなみに
        if userDefaults.object(forKey: "memoArray") != nil {
            //memoArrayにuserDefualtsを打ち込む
            memoArray = userDefaults.array(forKey: "memoArray") as! [String]
            dateArray = userDefaults.array(forKey: "dateArray") as! [String]
            print("おけ")
        }
        
        //もし前の画面で語彙を追加してたら
        if addContext != nil {
            //memoArrayに入れて、保存
            memoArray.append(addContext)
            userDefaults.set(memoArray, forKey: "memoArray")
            
            dateArray.append(addDate)
            userDefaults.setValue(dateArray, forKey: "dateArray")
        }
        
    }
    
    //数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    //内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = memoArray[indexPath.row]
        cell?.detailTextLabel?.text = dateArray[indexPath.row]
        
        return cell!
    }
    
    
    
    //editingstyleおよびスワイプにおける削除機能の追加
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            // 先にデータを削除しないと、エラーが発生します。
            self.memoArray.remove(at: indexPath.row)
            self.dateArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            userDefaults.set(memoArray, forKey: "memoArray")
            userDefaults.set(dateArray, forKey: "dateArray")
    }
    
    //削除ボタンの文字を変える
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除する"
    }

    //並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = memoArray[sourceIndexPath.row]
        memoArray.remove(at: sourceIndexPath.row)
        memoArray.insert(todo, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "編集") { (ctxAction, view, completionHandler) in
            print("赤サタな")
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //編集機能で削除できないようにする
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //インデント無くす(左の余分なスペース)
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    
    @IBAction func tapEdit(sender: AnyObject) {
            if isEditing {
                super.setEditing(false, animated: true)
                table.setEditing(false, animated: true)
            } else {
                super.setEditing(true, animated: true)
                table.setEditing(true, animated: true)
            }
        }


}



