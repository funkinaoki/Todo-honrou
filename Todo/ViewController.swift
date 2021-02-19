//
//  ViewController.swift
//  Todo
//
//  Created by 八幡尚希 on 2021/02/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet var editButton: UIButton!
    
    var memoArray = [String]()
    
    var dateArray = [String]()
    
    var currentMemoArray = [String]()
    
    var currentDateArray = [String]()
    
    let userDefaults = UserDefaults.standard
    
    var addContext: String!
    
    var addDate: String!
    
    var editMemo: String!
    
    var editDate: String!
    
    var editArrayNumber: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        table.delegate = self
        
        search.delegate = self
        
        memoArray = ["明るい朝", "異色な人たち"]
        
        dateArray = ["", ""]
        
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
        
        //もし編集画面から戻ってきたら指定の配列の情報を変更し、保存
        if editMemo != nil {
            memoArray[editArrayNumber] = editMemo
            userDefaults.set(memoArray, forKey: "memoArray")
            
            dateArray[editArrayNumber] = editDate
            userDefaults.setValue(dateArray, forKey: "dateArray")
        }
        
        currentMemoArray = memoArray
        currentDateArray = dateArray
        
    }
    
    //数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return currentMemoArray.count
       }
    
    //内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = currentMemoArray[indexPath.row]
        cell?.detailTextLabel?.text = currentDateArray[indexPath.row]
        
        return cell!
    }
    
    //editingstyleおよびスワイプにおける削除機能の追加
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//            // 先にデータを削除しないと、エラーが発生します。
//            self.memoArray.remove(at: indexPath.row)
//            self.dateArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            userDefaults.set(memoArray, forKey: "memoArray")
//            userDefaults.set(dateArray, forKey: "dateArray")
//    }
//
    //削除ボタンの文字を変える
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除する"
    }

    //並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = currentMemoArray[sourceIndexPath.row]
        currentMemoArray.remove(at: sourceIndexPath.row)
        currentMemoArray.insert(todo, at: destinationIndexPath.row)
        
        self.userDefaults.set(self.currentMemoArray, forKey: "memoArray")
        self.userDefaults.set(self.currentDateArray, forKey: "dateArray")
    }
    
    //edit機能で削除できないようにする
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //インデント無くす(左の余分なスペース)
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //前方スワイプ
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //action1
        let action = UIContextualAction(style: .normal, title: "編集") { (ctxAction, view, completionHandler) in
            print(self.currentMemoArray[indexPath.row])
            self.editMemo = self.currentMemoArray[indexPath.row]
            self.editDate = self.currentDateArray[indexPath.row]
            self.editArrayNumber = indexPath.row
            self.toEdit()
            completionHandler(true)
            
        }
        
        //action2
        let action2 = UIContextualAction(style: .destructive, title: "がんばれ！") { (ctxAction, view, completionHandler) in
            let alert: UIAlertController = UIAlertController(title:"がんばれー！", message: "ファイティン", preferredStyle: .alert)
            alert.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: { action in
                                //押された際のアクション
                                self.navigationController?.popViewController(animated: true)
                            }
                        )
            )
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action,action2])
    }
    
    //後方スワイプ
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "削除する") { (ctxAction, view, completionHandler) in
             //先にデータを削除しないと、エラーが発生します。
            self.currentMemoArray.remove(at: indexPath.row)
            self.currentDateArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.userDefaults.set(self.currentMemoArray, forKey: "memoArray")
            self.userDefaults.set(self.currentDateArray, forKey: "dateArray")
            
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
    @IBAction func tapEdit(sender: AnyObject) {
            if isEditing {
                super.setEditing(false, animated: true)
                table.setEditing(false, animated: true)
                sender.setTitle("Sort", for: .normal)
                sender.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
            } else {
                super.setEditing(true, animated: true)
                table.setEditing(true, animated: true)
                sender.setTitle("Done", for: .normal)
                sender.setTitleColor(UIColor(red: 1, green: 59 / 255, blue: 48 / 255, alpha: 1) , for: .normal)

            }
        }
    
    //MARK: - 渡された文字列を含む要素を検索し、テーブルビューを再表示する
    func searchItems(searchText: String) {
        //要素を検索する
        if searchText != "" {
            currentMemoArray = memoArray.filter { item in
                return item.contains(searchText)
            } as Array
        } else {
            //渡された文字列が空の場合は全てを表示
            currentMemoArray = memoArray
            currentDateArray = dateArray
        }
        //tableViewを再読み込みする
        table.reloadData()
    }
    
    // テキストが変更される毎に呼ばれる
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //検索する
        searchItems(searchText: searchText)
    }
    
    func toEdit() {
        performSegue(withIdentifier: "toEditView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditView" {
            let EditViewController = segue.destination as! EditViewController
            EditViewController.editMemo = self.editMemo
            EditViewController.editDate = self.editDate
            EditViewController.editArrayNumber = self.editArrayNumber
            
        }
    }


}



