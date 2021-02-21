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
    
    var todoArray: [Todo] = []
    
    var currentTodoArray: [Todo] = []
    
    var tmemoArray = [String]()
    
    var tdateArray = [String]()
    
    var tcheckArray = [Bool]()
    
    var memoArray = [String]()
    
    var dateArray = [String]()
    
    var currentMemoArray = [String]()
    
    var currentDateArray = [String]()
    
    var checkArray = [Bool]()
    
    var currentCheckArray = [Bool]()
    
    let userDefaults = UserDefaults.standard
    
    var addContext: String!
    
    var addDate: String!
    
    var editMemo: String!
    
    var editDate: String!
    
    var editArrayNumber: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      UserDefaults.standard.removeAll()
        
        table.dataSource = self
        
        table.delegate = self
        
        search.delegate = self
        
        todoArray.append(Todo(memo: "明るい朝", date: "", check: false))
        
        todoArray.append(Todo(memo: "暗い朝", date: "", check: false))
        
        todoArray.append(Todo(memo: "赤い朝", date: "", check: false))
        
        currentTodoArray.append(Todo(memo: "明るい", date: "", check: false))
        
        currentTodoArray.append(Todo(memo: "暗い", date: "", check: false))
        
        currentTodoArray.append(Todo(memo: "赤い", date: "", check: false))
        
//        print("\(todoArray[0].memo!)")
        
        memoArray = ["明るい朝", "異色な人たち"]
        
        dateArray = ["", ""]
        
        checkArray = [false, true]
        
        //もし今までにデータ保存してたら
        
        //output<本当はuserDefaults.set(todoArray[x].memo, forKey: "memo")にしたいが、最後の単語しか入らない。>
//        for x in 0..<todoArray.count {
//            tmemoArray.append(todoArray[x].memo)
//            tdateArray.append(todoArray[x].date)
//            tcheckArray.append(todoArray[x].check)
//        }
//        userDefaults.set(tmemoArray, forKey: "memo")
//        userDefaults.set(tdateArray, forKey: "date")
//        userDefaults.set(tcheckArray, forKey: "check")
        
//        print(UserDefaults.standard.dictionaryRepresentation().filter { $0.key.hasPrefix("memo") })
        
        //input
        if userDefaults.object(forKey: "memo") != nil {
            for x in 0..<userDefaults.array(forKey: "memo")!.count {
                todoArray[x].memo = userDefaults.array(forKey: "memo")?[x] as? String
                todoArray[x].date = userDefaults.array(forKey: "date")?[x] as? String
                todoArray[x].check = userDefaults.array(forKey: "check")?[x] as? Bool
            }
        }
//
//        ///初回保存はまだ保存されてないからこれ起動しないよ！ちなみに
//        if userDefaults.object(forKey: "memoArray") != nil {
//            //memoArrayにuserDefualtsを打ち込む
//            memoArray = userDefaults.array(forKey: "memoArray") as! [String]
//            dateArray = userDefaults.array(forKey: "dateArray") as! [String]
//            checkArray = userDefaults.array(forKey: "checkArray") as! [Bool]
//
//        }
//
//        //もし前の画面で語彙を追加してたら
//        if addContext != nil {
//            //memoArrayに入れて、保存
//            memoArray.append(addContext)
//            userDefaults.set(memoArray, forKey: "memoArray")
//
//            dateArray.append(addDate)
//            userDefaults.setValue(dateArray, forKey: "dateArray")
//
//            checkArray.append(false)
//            userDefaults.setValue(checkArray, forKey: "checkArray")
//
//        }
        
//        //もし編集画面から戻ってきたら指定の配列の情報を変更し、保存
//        if editMemo != nil {
//            memoArray[editArrayNumber] = editMemo
//            userDefaults.setValue(memoArray, forKey: "memoArray")
//
//            dateArray[editArrayNumber] = editDate
//            userDefaults.setValue(dateArray, forKey: "dateArray")
//        }
//
        //検索用にcurrentに代入
        for x in 0..<todoArray.count {
            currentTodoArray[x].memo = todoArray[x].memo
            currentTodoArray[x].date = todoArray[x].date
            currentTodoArray[x].check = todoArray[x].check
        }
//        print(currentMemoArray)
//        print(currentCheckArray)
        
    }
    
    //アラートを表示
    override func viewDidAppear(_ animated: Bool) {
        if addContext != nil {
            let alert: UIAlertController = UIAlertController(title:"保存されました", message: "今後もよろしくお願いします", preferredStyle: .alert)
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
        }
    }
    
    //数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return currentTodoArray.count
       }
    
    //内容を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = currentTodoArray[indexPath.row].memo
        cell?.detailTextLabel?.text = currentTodoArray[indexPath.row].date
    
        if currentTodoArray[indexPath.row].check == true {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        //チェックが入ってたら無くす
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
            updateCheck(x: indexPath.row)
        } else {
            cell?.accessoryType = .checkmark
            updateCheck(x: indexPath.row)
        }
        
        //灰色を無くすために選択を解除する
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateCheck (x: Int) {
        checkArray[x].toggle()
        for x in 0..<todoArray.count {
            tcheckArray.append(todoArray[x].check)
        }
        userDefaults.setValue(tcheckArray, forKey: "checkArray")
    }
    
    //削除ボタンの文字を変える
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除する"
    }

//    //並び替え
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let todo = currentMemoArray[sourceIndexPath.row]
//        currentMemoArray.remove(at: sourceIndexPath.row)
//        currentMemoArray.insert(todo, at: destinationIndexPath.row)
//
//        self.userDefaults.set(self.currentMemoArray, forKey: "memoArray")
//        self.userDefaults.set(self.currentDateArray, forKey: "dateArray")
//    }
    
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
//    func searchItems(searchText: String) {
//        //要素を検索する
//        if searchText != "" {
//            currentMemoArray = memoArray.filter { item in
//                return item.contains(searchText)
//
//            } as Array
//        } else {
//            //渡された文字列が空の場合は全てを表示
//            currentMemoArray = memoArray
//            currentDateArray = dateArray
//            currentCheckArray = checkArray
//        }
//        //tableViewを再読み込みする
//        table.reloadData()
//    }
//
//    // テキストが変更される毎に呼ばれる
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //検索する
//        searchItems(searchText: searchText)
//    }
    
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
extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}



